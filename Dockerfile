FROM python:3.12-bullseye@sha256:b3f5d3336bd98e421e34833b01c9f2c3f3c15fafe201df24929223a8a4b6780c

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
