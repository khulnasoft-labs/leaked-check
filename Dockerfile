FROM python:3.11-bullseye@sha256:61cddcf3be1b54c518b4a9132c933f36042f20987f6420fede955419b7ef02e9

ARG OSSGADGET_VERSION="0.1.406"

WORKDIR /app

COPY dist/leakedcheck-*.tar.gz /app/

RUN cd /app && \
    pip install leakedcheck-*.tar.gz

# Install OSS Gadget
# License: MIT
RUN cd /opt && \
    wget -q https://github.com/microsoft/OSSGadget/releases/download/v${OSSGADGET_VERSION}/OSSGadget_linux_${OSSGADGET_VERSION}.tar.gz -O OSSGadget.tar.gz && \
    tar zxvf OSSGadget.tar.gz && \
    rm OSSGadget.tar.gz && \
    mv OSSGadget_linux_${OSSGADGET_VERSION} OSSGadget && \
    sed -i 's@${currentdir}@/tmp@' OSSGadget/nlog.config

ENV PATH="$PATH:/opt/OSSGadget"

ENTRYPOINT ["leakedcheck"]
