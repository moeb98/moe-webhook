#!/bin/bash
REPO=mrmoe/moe-webhook
VER=2.8.0
BASEIMAGE=alpine:3.14.1

case "$1" in
	"build")
		docker buildx build \
	      --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6 \
  	      -t $REPO:latest -t $REPO:$(git describe --tags `git rev-list --tags --max-count=1`) --push \
	      --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	      --build-arg VCS_REF=`git rev-parse --short HEAD` \
	      --build-arg BASEIMAGE=$BASEIMAGE \
	      --build-arg VERSION=$VER .
		;;
	"console")
		docker run -it --rm --entrypoint "/bin/ash" $REPO:latest
		;;
	* )
		cat << EOF
setup script
—————————————————————————————
Usage:
docker-make.sh build – build docker image
docker-make.sh console – start console
EOF
		;;
esac
