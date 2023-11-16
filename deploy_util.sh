#!/bin/sh

set -e

# $1: docker image name, like `image` or `image:tag`.
# $2: time tag.
# $3: the number of latest images to keep.
docker_pull_with_tag() {
  image=$1
  time_tag=$2
  keep_latest=$3

  image_without_tag=${image%%:*} # `image:tag` -> `image`

  if [ "${time_tag}" == "" ]; then
    time_tag=$(date +%F_%H-%M-%S)
  fi

  if [ "${keep_latest}" == "" ]; then
    keep_latest=7
  fi
  keep_latest=$((keep_latest + 1))

  docker pull "${image}"
  docker tag "${image}" "${image_without_tag}:latest" #  tag as latest
  docker tag "${image}" "${image_without_tag}:${time_tag}" #  tag as DATE_TIME

  # Keep latest images
  docker images | grep "^${image_without_tag} " | grep ' [0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\} ' | sort -r | tail -n +${keep_latest} | awk '{print $2}' | while read tag; do docker rmi "${image_without_tag}:${tag}"; done
} 
