ARG BASE_IMAGE

FROM rust:slim-buster AS builder

ARG MDBOOK_VERSION
ENV ARC="x86_64-unknown-linux-musl"
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    musl-tools
RUN rustup target add "${ARC}"
RUN cargo install mdbook --version "${MDBOOK_VERSION}" --target "${ARC}"


FROM $BASE_IMAGE

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
COPY --from=builder /usr/local/cargo/bin/mdbook /usr/bin/mdbook

WORKDIR /book
ENTRYPOINT [ "/usr/bin/mdbook" ]
