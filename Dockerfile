ARG BASE_IMAGE

FROM rust:alpine AS builder

RUN apk update && \
    apk add musl-dev
ENV ARC="x86_64-unknown-linux-musl"
RUN rustup target add "${ARC}"
RUN cargo install mdbook --target "${ARC}"
RUN cargo install mdbook-catppuccin --target "${ARC}"

FROM $BASE_IMAGE

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
COPY --from=builder /usr/local/cargo/bin/mdbook /usr/bin/mdbook
COPY --from=builder /usr/local/cargo/bin/mdbook-catppuccin /usr/bin/mdbook-catppuccin

WORKDIR /book
ENTRYPOINT [ "/usr/bin/mdbook" ]


