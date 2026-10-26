#!/usr/bin/env bash
# Generate k0s autopilot update channels from k0sproject/k0s GitHub releases.
#
# Usage: k0s-update-channel.sh <output dir>
#
# Writes <output dir>/stable/index.yaml (newest stable release) and
# <output dir>/stable/v1.MINOR/index.yaml for the newest 3 minor lines.
# Nothing is written unless every selected release passes validation.

set -euo pipefail

KEEP_MINORS=3
ARCH=amd64
REPO=k0sproject/k0s

out=${1:?usage: $0 <output dir>}

curl_gh() {
  local auth=()
  if [[ -n ${GH_TOKEN:-} ]]; then
    auth=(-H "Authorization: Bearer ${GH_TOKEN}")
  fi
  curl -sSfL --retry 3 -H 'Accept: application/vnd.github+json' "${auth[@]}" "$@"
}

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

# Fetch all releases.
page=1
echo '[]' >"$work/releases.json"
while :; do
  curl_gh "https://api.github.com/repos/${REPO}/releases?per_page=100&page=${page}" >"$work/page.json"
  [[ $(jq length "$work/page.json") -eq 0 ]] && break
  jq -s 'add' "$work/releases.json" "$work/page.json" >"$work/merged.json"
  mv "$work/merged.json" "$work/releases.json"
  page=$((page + 1))
done

# Newest release of each minor line, newest 3 minors first.
# Versions are compared numerically, including the +k0s.N revision.
jq -c --argjson keep "$KEEP_MINORS" '
  [ .[]
    | select(.draft | not)
    | select(.prerelease | not)
    | select(.tag_name | test("^v[0-9]+\\.[0-9]+\\.[0-9]+\\+k0s\\.[0-9]+$"))
    | . + {v: (.tag_name | [scan("[0-9]+")] | map(tonumber))}
  ]
  | group_by(.v[0:2])
  | map(max_by(.v))
  | sort_by(.v) | reverse
  | .[0:$keep]
  | map({tag: .tag_name, minor: "v\(.v[0]).\(.v[1])", v, assets})
' "$work/releases.json" >"$work/selected.json"

count=$(jq length "$work/selected.json")
if [[ $count -ne $KEEP_MINORS ]]; then
  echo "expected ${KEEP_MINORS} minor lines, found ${count}" >&2
  exit 1
fi

mkdir -p "$work/stable"
for i in $(seq 0 $((count - 1))); do
  rel=$(jq -c ".[$i]" "$work/selected.json")
  tag=$(jq -r .tag <<<"$rel")
  minor=$(jq -r .minor <<<"$rel")
  name="k0s-${tag}-${ARCH}"

  url=$(jq -r --arg n "$name" '.assets[] | select(.name == $n) | .browser_download_url' <<<"$rel")
  digest=$(jq -r --arg n "$name" '.assets[] | select(.name == $n) | .digest // ""' <<<"$rel")
  sums_url=$(jq -r '.assets[] | select(.name == "sha256sums.txt") | .browser_download_url' <<<"$rel")
  if [[ -z $url || -z $sums_url ]]; then
    echo "${tag}: missing ${name} or sha256sums.txt" >&2
    exit 1
  fi

  sha=$(curl -sSfL --retry 3 "$sums_url" | awk -v n="$name" '{f = $2; sub(/^\*/, "", f)} f == n {print $1}')
  if [[ ! $sha =~ ^[0-9a-f]{64}$ ]]; then
    echo "${tag}: no valid checksum for ${name} in sha256sums.txt" >&2
    exit 1
  fi
  if [[ -n $digest && $digest != "sha256:${sha}" ]]; then
    echo "${tag}: sha256sums.txt (${sha}) disagrees with asset digest (${digest})" >&2
    exit 1
  fi
  curl -sSfIL --retry 3 -o /dev/null "$url"

  mkdir -p "$work/stable/${minor}"
  cat >"$work/stable/${minor}/index.yaml" <<EOF
channel: ${minor}
version: ${tag}
downloadURLs:
- os: linux
  arch: ${ARCH}
  k0s: ${url}
  k0sSha256: ${sha}
EOF

  if [[ $i -eq 0 ]]; then
    cp "$work/stable/${minor}/index.yaml" "$work/stable/index.yaml"
  fi
done

# Refuse to move the stable channel backwards.
version_key() {
  [[ $1 =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)\+k0s\.([0-9]+)$ ]] || return 1
  printf '%05d%05d%05d%05d' "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}" "${BASH_REMATCH[4]}"
}
new=$(awk '/^version:/ {print $2}' "$work/stable/index.yaml")
if [[ -f $out/stable/index.yaml ]]; then
  old=$(awk '/^version:/ {print $2}' "$out/stable/index.yaml")
  if [[ $(version_key "$new") < $(version_key "$old") ]]; then
    echo "refusing to downgrade stable from ${old} to ${new}" >&2
    exit 1
  fi
fi

mkdir -p "$out"
rm -rf "$out/stable"
mv "$work/stable" "$out/stable"
echo "stable: ${new}; minors: $(jq -r 'map(.tag) | join(", ")' "$work/selected.json")"
