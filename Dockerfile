FROM python:3.10.6-alpine3.15 AS base
RUN apk add --no-cache --update openssh-client bash git
FROM base AS builder
LABEL maintainer="Chudakov Aleksandr chudo@iudanet.com"

RUN apk add --no-cache --update \
    linux-headers \
    gcc \
    musl-dev \
    python3-dev \
    libffi-dev \
    openssl-dev

ENV VIRTUAL_ENV=/opt/venv
ENV PIP_VERSION=22.0.3
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN python3 -m venv  $VIRTUAL_ENV


COPY requirements.txt /requirements.txt
RUN  pip install --no-cache-dir --upgrade pip==${PIP_VERSION} \
    && pip install --no-cache-dir wheel \
    && pip install --no-cache-dir -r /requirements.txt
FROM base
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
COPY --from=builder $VIRTUAL_ENV $VIRTUAL_ENV
