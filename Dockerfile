ARG MAGNETICOD_VERSION=v0.12.0

FROM alpine:latest as base

ARG MAGNETICOD_VERSION

ADD https://github.com/boramalper/magnetico/releases/download/$MAGNETICOD_VERSION/magneticod /magneticod

RUN chmod 755 /magneticod

FROM gcr.io/distroless/cc-debian10:latest

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG MAGNETICOD_VERSION

LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="jackett-distroless" \
    org.label-schema.description="Distroless container for the Magneticod program" \
    org.label-schema.url="https://guillaumedsde.gitlab.io/magneticod-distroless/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version=$MAGNETICOD_VERSION \
    org.label-schema.vcs-url="https://github.com/guillaumedsde/magneticod-distroless" \
    org.label-schema.vendor="guillaumedsde" \
    org.label-schema.schema-version="1.0"

COPY --from=base /magneticod /magneticod

VOLUME /data
VOLUME /config

ENV XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/data


ENTRYPOINT [ "/magneticod" ]