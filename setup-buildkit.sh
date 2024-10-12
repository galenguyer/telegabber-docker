#!/usr/bin/env bash

# set up buildkit for multiple platforms
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --use --platform linux/arm64/v8,linux/arm/v7,linux/arm/v6,linux/amd64,linux/386
