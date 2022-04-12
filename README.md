<!-- https://shields.io/ -->

[![license](https://img.shields.io/github/license/peaceiris/docker-mdbook.svg)](https://github.com/peaceiris/docker-mdbook/blob/main/LICENSE)
[![release](https://img.shields.io/github/release/peaceiris/docker-mdbook.svg)](https://github.com/peaceiris/docker-mdbook/releases/latest)
[![GitHub release date](https://img.shields.io/github/release-date/peaceiris/docker-mdbook.svg)](https://github.com/peaceiris/docker-mdbook/releases)
[![GitHub Actions status](https://github.com/peaceiris/docker-mdbook/workflows/Docker%20Image%20CI/badge.svg)](https://github.com/peaceiris/docker-mdbook/actions)

<img width="400" alt="Docker image for mdBook" src="./images/ogp.jpg">



## Alpine Base Docker Image for mdBook

Alpine base Docker Image for [rust-lang/mdBook].

[rust-lang/mdBook]: https://github.com/rust-lang/mdBook

- [peaceiris/mdbook - Docker Hub]

[peaceiris/mdbook - Docker Hub]: https://hub.docker.com/r/peaceiris/mdbook

[![DockerHub Badge](https://dockeri.co/image/peaceiris/mdbook)][peaceiris/mdbook - Docker Hub]

Docker images on GitHub Packages [ghcr.io/peaceiris/mdbook] are also available.

[ghcr.io/peaceiris/mdbook]: https://github.com/users/peaceiris/packages/container/package/mdbook



## Getting started

| Image tag | Base Image | Image size | Notes |
|---|---|---|---|
| `peaceiris/mdbook:v0.x.x` | `alpine:3.15` | 24MB | Minimum image |
| `peaceiris/mdbook:v0.x.x-rust` | `rust:1.60-alpine3.15` | 880MB | `mdbook test` subcommand is available |
| `ghcr.io/peaceiris/mdbook:v0.x.x` | `alpine:3.15` | 24MB | GitHub Packages: Minimum image |
| `ghcr.io/peaceiris/mdbook:v0.x.x-rust` | `rust:1.60-alpine3.15` | 880MB | GitHub Packages: `mdbook test` subcommand is available |

### Docker Compose

Create your `docker-compose.yml` like the following.

```yaml
version: '3'

services:
  mdbook:
    container_name: mdbook
    image: peaceiris/mdbook:v0.x.x            # Minimum image
    # image: peaceiris/mdbook:v0.x.x-rust     # `mdbook test` subcommand is available
    # image: ghcr.io/peaceiris/mdbook:v0.x.x  # Docker images on GitHub Packages
    stdin_open: true
    tty: true
    ports:
      - 3000:3000
      - 3001:3001
    volumes:
      - ${PWD}:/book
    command:
      - serve
      - --hostname
      - '0.0.0.0'
```

### Usage

```sh
# Run "mdbook serve"
docker-compose up

# Run a command of mdBook
docker-compose run --rm mdbook init
```



## GitHub Actions for mdBook

The mdBook Setup GitHub Action is recommended.

- [peaceiris/actions-mdbook: GitHub Actions for mdBook (rust-lang/mdBook) ⚡️ Setup mdBook quickly and build your site fast. Linux (Ubuntu), macOS, and Windows are supported.](https://github.com/peaceiris/actions-mdbook)



## License

- [MIT License - peaceiris/docker-mdbook]

[MIT License - peaceiris/docker-mdbook]: https://github.com/peaceiris/docker-mdbook/blob/main/LICENSE



## About the author

- [peaceiris homepage](https://peaceiris.com/)
