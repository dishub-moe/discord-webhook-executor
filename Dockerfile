FROM swift:5.9.2-jammy as build

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get -q update \
    && apt-get -q dist-upgrade -y\
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

COPY ./Package.* ./
RUN swift package resolve

COPY . .

RUN swift build -c release --static-swift-stdlib
