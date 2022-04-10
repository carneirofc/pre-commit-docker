FROM python:3.9.12-alpine3.15
ENV PRE_COMMIT_HOOKS_VERSION v4.2.0
RUN pip install pre-commit==2.18.1 && \
    mkdir /pre-commit && \
    apk add git gcc build-base && \
    git clone https://github.com/pre-commit/pre-commit-hooks && \
    cd pre-commit-hooks && git checkout ${PRE_COMMIT_HOOKS_VERSION}
WORKDIR /pre-commit

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && git init && /entrypoint.sh && rm -rfv .git && apk del gcc build-base

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
