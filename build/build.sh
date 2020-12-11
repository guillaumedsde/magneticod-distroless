#!/bin/sh
set -x

VERSION=${VERSION:-"$(curl --silent "https://api.github.com/repos/boramalper/magnetico/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')"}

if [ "${CI_COMMIT_REF_NAME}" = "master" ]; then
    TAGS=" -t ${CI_REGISTRY_USER}/${CI_PROJECT_NAME}:${VERSION} -t ${CI_REGISTRY_USER}/${CI_PROJECT_NAME}:latest "
else
    # tag image with branch name
    TAGS="-t ${CI_REGISTRY_USER}/${CI_PROJECT_NAME}:${CI_COMMIT_REF_SLUG}"
fi

# shellcheck disable=SC2086
docker buildx build . \
    --platform="${BUILDX_PLATFORM}" \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg VCS_REF="${CI_COMMIT_SHORT_SHA}" \
    --build-arg MAGNETICOD_VERSION="${VERSION}" \
    ${TAGS} \
    --push
