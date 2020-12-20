#!/bin/bash

OS="$(echo $TARGETPLATFORM | cut -f1 -d '/')"
ARCH="$(echo $TARGETPLATFORM | cut -f2 -d '/')"

GOOS="$OS" GOARCH="$ARCH" make magneticod

if [[ "$TARGETPLATFORM" == "$BUILDPLATFORM" ]]; then
    BINARY="/go/bin/magneticod"
else
    BINARY="/go/bin/${OS}_${ARCH}/magneticod"
fi

cp "$BINARY" ./magneticod
