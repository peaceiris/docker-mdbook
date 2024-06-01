ARG BASE_IMAGE

FROM rust:1.78-slim-bookworm AS builder

ARG TARGETPLATFORM
ARG MDBOOK_VERSION
ARG CARGO_TARGET
ARG MDBOOK_MERMAID_VERSION
ARG MDBOOK_TOC_VERSION
ARG MDBOOK_ADMONISH_VERSION

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    musl-tools \
    file
RUN rustup target add "${CARGO_TARGET}"
RUN cargo install mdbook --version "${MDBOOK_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook)"
RUN cargo install mdbook-mermaid --version "${MDBOOK_MERMAID_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook-mermaid)"
RUN cargo install mdbook-toc --version "${MDBOOK_TOC_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook-toc)"
RUN cargo install mdbook-admonish --version "${MDBOOK_ADMONISH_VERSION}" --target "${CARGO_TARGET}" && \
    strip "$(which mdbook-admonish)"

FROM ${BASE_IMAGE}

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
COPY --from=builder /usr/local/cargo/bin/mdbook /usr/bin/mdbook
COPY --from=builder /usr/local/cargo/bin/mdbook-mermaid /usr/bin/mdbook-mermaid
COPY --from=builder /usr/local/cargo/bin/mdbook-toc /usr/bin/mdbook-toc
COPY --from=builder /usr/local/cargo/bin/mdbook-admonish /usr/bin/mdbook-admonish

WORKDIR /book
ENTRYPOINT [ "/usr/bin/mdbook" ]
