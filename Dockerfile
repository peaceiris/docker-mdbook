ARG BASE_IMAGE

FROM rust:1.78-slim-bookworm AS builder

ARG TARGETPLATFORM
ARG MDBOOK_VERSION
ENV ARC_AMD64="x86_64-unknown-linux-musl"
ENV ARC_ARM64="aarch64-unknown-linux-musl"

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    musl-tools
RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
        rustup target add "${ARC_AMD64}"; \
    elif [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        rustup target add "${ARC_ARM64}"; \
    fi
RUN if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
        cargo install mdbook --version "${MDBOOK_VERSION}" --target "${ARC_AMD64}"; \
    elif [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
        cargo install mdbook --version "${MDBOOK_VERSION}" --target "${ARC_ARM64}"; \
    fi

FROM $BASE_IMAGE

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
COPY --from=builder /usr/local/cargo/bin/mdbook /usr/bin/mdbook

WORKDIR /book
ENTRYPOINT [ "/usr/bin/mdbook" ]
