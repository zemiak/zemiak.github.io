#!/bin/sh

version=3.8
tag=jekyll-builder-${version}

docker rm -f ${tag} || exit 10
docker run --name=${tag} -d jekyll/builder:${version} //bin/true || exit 20
sleep 5s || exit 30
docker cp -r ./_src/* ${tag}:/srv/jekyll/ || exit 40
docker exec ${tag} jekyll build || exit 50
rm -rf _site || exit 60
mkdir _site || exit 70
docker cp -r ${tag}:/srv/jekyll/ _site/ || exit 80
docker rm -f ${tag} || exit 90

