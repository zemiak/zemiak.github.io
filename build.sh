#!/bin/sh

version=3.8
tag=jekyll-builder-${version}

docker rm -f ${tag}

echo Starting container ...
docker run --name=${tag} -d jekyll/builder:${version} tail -f //etc/hosts || exit 20

echo Waiting for 3 seconds ...
sleep 3s || exit 30

echo Copying files into container ...
docker cp ./_src/* ${tag}:/srv/jekyll/ || exit 40

echo Building ...
docker exec ${tag} jekyll build || exit 50

echo Copying site out of the container ...
rm -rf _site || exit 60
mkdir _site || exit 70
docker cp ${tag}:/srv/jekyll/ _site/ || exit 80

docker rm -f ${tag}
