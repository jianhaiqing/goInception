#!/bin/bash

commitid=`git rev-parse HEAD | cut -c1-9`
branch=`git symbolic-ref --short -q HEAD`
echo "${branch}-${commitid}"
curtime=`date +%m%d%H%M`
echo `pwd`
echo "编译本地镜像"
echo "$commitid"

dockertag="goinception:${branch}-${commitid}-${curtime}"
echo "${dockertag}"
docker build -t ${dockertag} -f Dockerfile-goinception `pwd`

echo "本地镜像tag"

docker tag ${dockertag}  "registry.gz.cvte.cn/percona/${dockertag}"

echo "push 镜像到registry.gz.cvte.cn/percona"
docker push "registry.gz.cvte.cn/percona/${dockertag}"

echo "succeed"
