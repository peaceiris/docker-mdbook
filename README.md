<!-- https://shields.io/ -->

[![license](https://img.shields.io/github/license/peaceiris/docker-mdbook.svg)](https://github.com/peaceiris/docker-mdbook/blob/main/LICENSE)

<img width="400" alt="Docker image for mdBook" src="./images/ogp.jpg">



## Alpine-Based Docker Images for mdBook

Alpine-based Docker Images for [rust-lang/mdBook].

[rust-lang/mdBook]: https://github.com/rust-lang/mdBook

- [peaceiris/mdbook - Docker Hub]

[peaceiris/mdbook - Docker Hub]: https://hub.docker.com/r/peaceiris/mdbook

[![DockerHub Badge](https://dockeri.co/image/peaceiris/mdbook)][peaceiris/mdbook - Docker Hub]

Docker images on GitHub Packages [ghcr.io/peaceiris/mdbook] are also available.

[ghcr.io/peaceiris/mdbook]: https://github.com/users/peaceiris/packages/container/package/mdbook

CPU architectures amd64 and arm64 are supported.


## Pre-installed preprocessors for mdBook

- [mdbook-mermaid]
- [mdbook-toc]

[mdbook-mermaid]: https://github.com/badboy/mdbook-mermaid
[mdbook-toc]: https://github.com/badboy/mdbook-toc



## Getting started

### Available Docker Image Tags

| Image tag (mdBook version) | Base Image | Image size | Notes |
|---|---|---|---|
| `peaceiris/mdbook:v0.x.x` | `alpine:3.20` | 30MB | Minimum image |
| `peaceiris/mdbook:v0.x.x-rust` | `rust:1.78-alpine3.20` | 855MB | `mdbook test` subcommand is available |
| `ghcr.io/peaceiris/mdbook:v0.x.x` | `alpine:3.20` | 30MB | GitHub Packages: Minimum image |
| `ghcr.io/peaceiris/mdbook:v0.x.x-rust` | `rust:1.78-alpine3.20` | 855MB | GitHub Packages: `mdbook test` subcommand is available |

### Docker Compose

Please refer to the example project and the [`compose.yml`](https://github.com/peaceiris/docker-mdbook/blob/main/example/compose.yml).

```sh
cd ./example

# Run "mdbook serve"
docker compose up

# Run "mdbook build"
docker compose run --rm mdbook build

# Run "mdbook init"
docker compose run --rm mdbook init
```



## GitHub Actions for mdBook

The mdBook Setup GitHub Action is recommended.

- [peaceiris/actions-mdbook: GitHub Actions for mdBook (rust-lang/mdBook) ⚡️ Setup mdBook quickly and build your site fast. Linux (Ubuntu), macOS, and Windows are supported.](https://github.com/peaceiris/actions-mdbook)



## License

- [MIT License - peaceiris/docker-mdbook]

[MIT License - peaceiris/docker-mdbook]: https://github.com/peaceiris/docker-mdbook/blob/main/LICENSE



## About the author

- [peaceiris homepage](https://peaceiris.com/)
