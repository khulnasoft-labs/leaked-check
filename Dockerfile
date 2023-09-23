FROM python:3.11-bullseye@sha256:b9b89c22889a2d867327c8166d1388ec4069e6d1c10c6179fafba50425be0e48

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
