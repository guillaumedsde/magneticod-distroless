# [🐋 Magneticod-distroless](https://github.com/guillaumedsde/magneticod-distroless)

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/guillaumedsde/magneticod-distroless)](https://hub.docker.com/r/guillaumedsde/magneticod-distroless/builds)
[![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/guillaumedsde/magneticod-distroless?label=documentation)](https://guillaumedsde.gitlab.io/magneticod-distroless/)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/guillaumedsde/magneticod-distroless)](https://hub.docker.com/r/guillaumedsde/magneticod-distroless/builds)
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/guillaumedsde/magneticod-distroless)](https://hub.docker.com/r/guillaumedsde/magneticod-distroless/tags)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/guillaumedsde/magneticod-distroless)](https://hub.docker.com/r/guillaumedsde/magneticod-distroless)
[![Docker Pulls](https://img.shields.io/docker/pulls/guillaumedsde/magneticod-distroless)](https://hub.docker.com/r/guillaumedsde/magneticod-distroless)
[![GitHub stars](https://img.shields.io/github/stars/guillaumedsde/magneticod-distroless?label=Github%20stars)](https://github.com/guillaumedsde/magneticod-distroless)
[![GitHub watchers](https://img.shields.io/github/watchers/guillaumedsde/magneticod-distroless?label=Github%20Watchers)](https://github.com/guillaumedsde/magneticod-distroless)
[![Docker Stars](https://img.shields.io/docker/stars/guillaumedsde/magneticod-distroless)](https://hub.docker.com/r/guillaumedsde/magneticod-distroless)
[![GitHub](https://img.shields.io/github/license/guillaumedsde/magneticod-distroless)](https://github.com/guillaumedsde/magneticod-distroless/blob/master/LICENSE.md)

This repository contains the code to build a small and secure **[distroless](https://github.com/GoogleContainerTools/distroless)** **docker** image for **[Magneticod](https://github.com/Magneticod/Magneticod)** which can be run as an unprivileged user.
The final images are built and hosted on the [dockerhub](https://hub.docker.com/r/guillaumedsde/magneticod-distroless) and the documentation is hosted on [gitlab pages](https://guillaumedsde.gitlab.io/magneticod-distroless/)

## ✔️ Features summary

- 🥑 [distroless](https://github.com/GoogleContainerTools/distroless) minimal image
- 🤏 As few Docker layers as possible
- 🛡️ only basic runtime dependencies
- 🛡️ Runs as unprivileged user with minimal permissions

## 🏁 How to Run

### `docker run`

```bash
$ docker run  -v /your/config/path/:/config \
              -v /your/torrent/blackhole/path/:/blackhole \
              -v /etc/localtime:/etc/localtime:ro \
              -e PUID=1000 \
              -e PGID=1000 \
              -p 9117:9117 \
              guillaumedsde/magneticod-distroless:latest
```

#### 🧊 Read-only `docker run`

If you want your container to be _even_ more secure, you can run it with a read-only filesystem:

```bash
$ docker run  -v /your/config/path/:/config \
              -v /your/date/path/:/data \
              -v /etc/localtime:/etc/localtime:ro \
              --user "$(id -u):$(id -g)" \
              guillaumedsde/magneticod-distroless:latest
```

### `docker-compose.yml`

```yaml
version: "3.3"
services:
  magneticod-distroless:
    volumes:
      - "/your/config/path/:/config"
      - "/your/date/path/:/data"
      - "/etc/localtime:/etc/localtime:ro"
    user: 1000:1000
    read_only: true
    image: "guillaumedsde/magneticod-distroless:latest"
```

## 🖥️ Supported platforms

Currently this container supports only one (but widely used) platform:

- linux/amd64

I am waiting to see if Google implement their distroless Java images for other platforms (e.g. ARM based), for more information, see [here](https://github.com/GoogleContainerTools/distroless/issues/406) or [here](https://github.com/GoogleContainerTools/distroless/issues/377)

## 🙏 Credits

A couple of projects really helped me out while developing this container:

- 💽 [Magneticod](https://github.com/boramalper/magnetico) _the_ awesome software
- 🥑 [Google's distroless](https://github.com/GoogleContainerTools/distroless) base docker images
- 🐋 The [Docker](https://github.com/docker) project (of course)
