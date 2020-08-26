FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN set -ex && \
    apt-get update && \
    apt-get install -y xvfb \
                       freerdp2-x11 \
                       xdotool \
                       python-is-python2 \
                       wget \
                       ca-certificates \
                       openssl \
                       ppp \
                       iptables \ 
                       xclip

ENV RDP2TCP_VERSION=2020.08.26-0
RUN set -ex && \
    wget https://github.com/gerardo-junior/rdp2tcp/releases/download/${RDP2TCP_VERSION}/rdp2tcp.${RDP2TCP_VERSION}.tgz && \
    tar xzf rdp2tcp.${RDP2TCP_VERSION}.tgz && \
    mv rdp2tcp /opt && \
    rm rdp2tcp.*.tgz

ENV DISPLAY=:99

COPY ./tools /opt/tools
RUN chmod -Rf +x /opt/tools
ENTRYPOINT ["/opt/tools/entrypoint.sh"]
