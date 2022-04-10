FROM busybox:1.35 as builder
ARG PRE_COMMIT_HOOKS_VERSION=v4.2.0
ADD https://github.com/pre-commit/pre-commit-hooks/archive/refs/tags/${PRE_COMMIT_HOOKS_VERSION}.tar.gz /pre-commit-hooks.tar.gz
RUN tar -zxvf /pre-commit-hooks.tar.gz && rm /pre-commit-hooks.tar.gz && mv /pre-commit-hooks* /pre-commit-hooks

FROM python:3.9.12-alpine3.15
RUN pip install pre-commit==2.18.1 && mkdir /pre-commit
WORKDIR /pre-commit

COPY --from=builder /pre-commit-hooks /pre-commit-hooks
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]