# pre-commit-docker
pre-commit docker image for CI

A minimal and self-contained image with sensible defaults.

Image heavily inspired by [CREDITS To taghash](https://github.com/taghash/docker-pre-commit)

## Local usage

```sh
cd $(git rev-parse --show-toplevel)

NAME=$(basename `git rev-parse --show-toplevel`)_precommit
docker ps -a | grep $NAME &> /dev/null
CONTAINER_EXISTS=$?

if [[ CONTAINER_EXISTS -eq 0 ]]; then
    docker restart $NAME && docker attach --no-stdin $NAME
else
    docker run -t -v $(pwd):/pre-commit --name $NAME carneirofc/pre-commit
fi
```