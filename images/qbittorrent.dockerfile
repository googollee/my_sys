FROM docker.io/alpine:latest

RUN apk add --no-cache qbittorrent-nox
CMD ["/usr/bin/qbittorrent-nox", "--profile=/etc/qbittorrent", "--webui-port=80"]
