ARG BASE_IMAGE

FROM rust:1.78-slim-bookworm AS builder

ARG TARGETPLATFORM
ARG MDBOOK_VERSION
ENV ARC_AMD64="x86_64-unknown-linux-musl"
ENV ARC_ARM64="aarch64-unknown-linux-musl"
ARG MDBOOK_MERMAID_VERSION
ARG MDBOOK_TOC_VERSION

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    musl-tools \
    file
RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
        rustup target add "${ARC_AMD64}"; \
    elif [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        rustup target add "${ARC_ARM64}"; \
    fi
RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
        cargo install mdbook --version "${MDBOOK_VERSION}" --target "${ARC_AMD64}"; \
    elif [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        cargo install mdbook --version "${MDBOOK_VERSION}" --target "${ARC_ARM64}"; \
    fi && \
    strip "$(which mdbook)"
RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
        cargo install mdbook-mermaid --version "${MDBOOK_MERMAID_VERSION}" --target "${ARC_AMD64}"; \
    elif [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        cargo install mdbook-mermaid --version "${MDBOOK_MERMAID_VERSION}" --target "${ARC_ARM64}"; \
    fi && \
    strip "$(which mdbook-mermaid)"
RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
        cargo install mdbook-toc --version "${MDBOOK_TOC_VERSION}" --target "${ARC_AMD64}"; \
    elif [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        cargo install mdbook-toc --version "${MDBOOK_TOC_VERSION}" --target "${ARC_ARM64}"; \
    fi && \
    strip "$(which mdbook-toc)"

FROM $BASE_IMAGE

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
COPY --from=builder /usr/local/cargo/bin/mdbook /usr/bin/mdbook
COPY --from=builder /usr/local/cargo/bin/mdbook-mermaid /usr/bin/mdbook-mermaid
COPY --from=builder /usr/local/cargo/bin/mdbook-toc /usr/bin/mdbook-toc

WORKDIR /book
ENTRYPOINT [ "/usr/bin/mdbook" ]
