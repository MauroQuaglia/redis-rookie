#! /bin/bash

echo "Clean Docker for Redis..."
docker container stop redis-insight-redisinsight-1
docker container prune -f
docker image prune -af
docker volume prune -af
docker network prune -f
