FROM alpine:latest

WORKDIR /app

RUN apk update && apk add --no-cache curl tar

# Get latest release version
RUN version=$(curl -s "https://api.github.com/repos/alist-org/alist-proxy/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/') && \
    echo "Latest version: $version" && \
    version=${version#v} && \
    curl -L "https://github.com/alist-org/alist-proxy/releases/download/v${version}/alist-proxy_${version}_linux_arm64.tar.gz" -o alist-proxy.tar.gz && \
    tar -xzf alist-proxy.tar.gz && \
    rm -f README.md LICENSE && \
    chmod +x alist-proxy

EXPOSE 5243

ENTRYPOINT ["/app/alist-proxy"]

CMD ["-token", "xxx"]
