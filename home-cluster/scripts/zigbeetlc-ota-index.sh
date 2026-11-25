#!/usr/bin/env bash
# Generate a fixed-name zigpy/Z2M OTA index for pvvx/ZigbeeTLc from its latest GitHub release.
#
# Usage: zigbeetlc-ota-index.sh <output file>
#
# Reads bin/index_v*.json at the latest non-prerelease tag, rewrites every image URL
# to point at that tag (so URL, size and sha512 always match), downloads each image to
# verify it, then writes <output file>. Nothing is written unless all images verify.

set -euo pipefail

REPO=pvvx/ZigbeeTLc

out=${1:?usage: $0 <output file>}

curl_gh() {
  local auth=()
  if [[ -n ${GH_TOKEN:-} ]]; then
    auth=(-H "Authorization: Bearer ${GH_TOKEN}")
  fi
  curl -sSfL --retry 3 -H 'Accept: application/vnd.github+json' "${auth[@]}" "$@"
}

version_key() {
  [[ $1 =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)$ ]] || return 1
  printf '%05d%05d%05d%05d' "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[3]}" "${BASH_REMATCH[4]}"
}

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

tag=$(curl_gh "https://api.github.com/repos/${REPO}/releases/latest" | jq -r '.tag_name')
if ! version_key "$tag" >/dev/null; then
  echo "unexpected release tag: ${tag}" >&2
  exit 1
fi

# The index file name changes with every version; take the only/newest index_v*.json at the tag.
index=$(curl_gh "https://api.github.com/repos/${REPO}/contents/bin?ref=${tag}" | jq -r '
  [ .[] | .name | select(test("^index_v[0-9]+\\.json$")) ]
  | sort_by(scan("[0-9]+") | tonumber)
  | last // empty
')
if [[ -z $index ]]; then
  echo "${tag}: no bin/index_v*.json found" >&2
  exit 1
fi

curl -sSfL --retry 3 "https://raw.githubusercontent.com/${REPO}/${tag}/bin/${index}" >"$work/upstream.json"

jq --arg base "https://raw.githubusercontent.com/${REPO}/${tag}/bin/" '
  if type != "array" or length == 0 then error("index is not a non-empty array") else . end
  | map(
      if (.url | test("/bin/[^/]+\\.zigbee$")) and (.sha512 | test("^[0-9a-f]{128}$")) and (.fileSize | type == "number")
      then .url = $base + (.url | split("/") | last)
      else error("bad entry: \(.url)")
      end
    )
' "$work/upstream.json" >"$work/index.json"

count=$(jq length "$work/index.json")
for i in $(seq 0 $((count - 1))); do
  url=$(jq -r ".[$i].url" "$work/index.json")
  want_sha=$(jq -r ".[$i].sha512" "$work/index.json")
  want_size=$(jq -r ".[$i].fileSize" "$work/index.json")
  curl -sSfL --retry 3 -o "$work/image" "$url"
  size=$(stat -c %s "$work/image")
  sha=$(sha512sum "$work/image" | awk '{print $1}')
  if [[ $size -ne $want_size || $sha != "$want_sha" ]]; then
    echo "${url}: size/sha512 mismatch (got ${size}, want ${want_size})" >&2
    exit 1
  fi
done

# Refuse to move backwards if the latest release ever goes to an older tag.
if [[ -f $out ]]; then
  old=$(jq -r '.[0].url' "$out" | sed -nE "s#^https://raw.githubusercontent.com/${REPO}/([^/]+)/bin/.*#\1#p")
  if [[ -n $old ]] && version_key "$old" >/dev/null && [[ $(version_key "$tag") < $(version_key "$old") ]]; then
    echo "refusing to downgrade from ${old} to ${tag}" >&2
    exit 1
  fi
fi

mkdir -p "$(dirname "$out")"
mv "$work/index.json" "$out"
echo "${tag}: ${index}, ${count} images"
