#!/bin/sh

export JEKYLL_VERSION=3.8
docker rm -f jekyll-builder-${JEKYLL_VERSION}
docker run -d jekyll/builder:$JEKYLL_VERSION //bin/true
sleep 5s
docker cp -r ./_src/* jekyll-builder-${JEKYLL_VERSION}:/srv/jekyll/
docker exec jekyll-builder-${JEKYLL_VERSION} jekyll build
docker rm -f jekyll-builder-${JEKYLL_VERSION}
