#!/usr/bin/env bash
# build, tag, and push docker images

# exit if a command fails
set -o errexit
# exit if required variables aren't set
set -o nounset

# check for docker
if command -v docker 2>&1 >/dev/null; then
	echo "using docker..." >&2
else
	echo "could not find docker, exiting" >&2
	exit 1
fi

# check for jq
if ! command -v jq 2>&1 >/dev/null; then
       echo "could not find jq, exiting" >&2
       exit 1
fi

# if no registry is provided, tag image as "local" registry
registry="${REGISTRY:-local}"
echo "using registry $registry..." >&2

# retrieve latest debian version
#debian="${DEBIAN:-11.5}"
#echo "using alpine version $debian..." >&2

# pass core count into container for build process
core_count="${CORE_COUNT:-$(nproc)}"
echo "using $core_count cores..." >&2

# create docker images
#export DEBIAN_VER="$debian"
export CORE_COUNT="$core_count"
export REGISTRY="$registry"
docker buildx bake \
    $(if [ "${REGISTRY}" != "local" ]; then echo "--push"; fi) \
    "$@"
