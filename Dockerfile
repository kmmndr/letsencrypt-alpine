FROM alpine:3.12

ENV CA_FILE "/etc/ssl/certs/ca.pem"
ENV CERT_FILE "/etc/ssl/certs/public.crt"
ENV KEY_FILE "/etc/ssl/certs/public.key"

ENV LETSENCRYPT_SERVER ""
ENV LETSENCRYPT_DOMAIN "localhost"
ENV LETSENCRYPT_EMAIL "root@localhost"

RUN apk add --no-cache ca-certificates lego

COPY docker-entrypoint.sh /usr/local/bin

EXPOSE 80

VOLUME ["/var/lib/lego"]

STOPSIGNAL SIGKILL
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
