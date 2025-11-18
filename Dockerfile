# syntax=docker/dockerfile:1
ARG BASE_IMAGE

FROM rust:1.91.1-slim-bookworm AS builder

ARG TARGETPLATFORM
ARG MDBOOK_VERSION
ARG CARGO_TARGET
ARG MDBOOK_MERMAID_VERSION
ARG MDBOOK_TOC_VERSION
ARG MDBOOK_ADMONISH_VERSION
ARG MDBOOK_EXTERNAL_LINKS_VERSION

ENV CARGO_TARGET_DIR="/usr/local/cargo-target"

RUN rm -f /etc/apt/apt.conf.d/docker-clean && \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,sharing=locked,target=/var/cache/apt \
    --mount=type=cache,sharing=locked,target=/var/lib/apt \
    apt-get update && \
    apt-get install --no-install-recommends -y \
    musl-tools \
    file
RUN rustup target add "${CARGO_TARGET}"
RUN --mount=type=cache,sharing=locked,target=/usr/local/cargo-target \
    cargo install mdbook --version "${MDBOOK_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook)"
RUN --mount=type=cache,sharing=locked,target=/usr/local/cargo-target \
    cargo install mdbook-mermaid --version "${MDBOOK_MERMAID_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook-mermaid)"
RUN --mount=type=cache,sharing=locked,target=/usr/local/cargo-target \
    cargo install mdbook-toc --version "${MDBOOK_TOC_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook-toc)"
RUN --mount=type=cache,sharing=locked,target=/usr/local/cargo-target \
    cargo install mdbook-admonish --version "${MDBOOK_ADMONISH_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook-admonish)"
RUN --mount=type=cache,sharing=locked,target=/usr/local/cargo-target \
    cargo install mdbook-external-links --version "${MDBOOK_EXTERNAL_LINKS_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook-external-links)"

FROM ${BASE_IMAGE}

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
COPY --from=builder /usr/local/cargo/bin/mdbook /usr/bin/mdbook
COPY --from=builder /usr/local/cargo/bin/mdbook-mermaid /usr/bin/mdbook-mermaid
COPY --from=builder /usr/local/cargo/bin/mdbook-toc /usr/bin/mdbook-toc
COPY --from=builder /usr/local/cargo/bin/mdbook-admonish /usr/bin/mdbook-admonish
COPY --from=builder /usr/local/cargo/bin/mdbook-external-links /usr/bin/mdbook-external-links

WORKDIR /book
ENTRYPOINT [ "/usr/bin/mdbook" ]
