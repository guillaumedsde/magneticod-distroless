ARG MAGNETICOD_VERSION=v0.12.0

FROM golang:1.15-buster AS build

ARG MAGNETICOD_VERSION
# disable go proxy because of
# https://github.com/golang/go/issues/40949
ARG GOPROXY=direct
WORKDIR /magnetico

RUN git clone https://github.com/boramalper/magnetico.git . \
    && git checkout "${MAGNETICOD_VERSION}"

RUN make magneticod

RUN mkdir /data

FROM gcr.io/distroless/base-debian10:nonroot

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

COPY --from=build /go/bin/magneticod /magneticod

VOLUME /data
VOLUME /config

# Copy empty directory to /data and /config volumes
# to fix permissions until this is fixed:
# https://github.com/moby/moby/issues/2259
COPY --chown=nonroot:nonroot --from=build /data /data
COPY --chown=nonroot:nonroot --from=build /data /config

ENV XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/data

ENTRYPOINT [ "/magneticod" ]