# Repository Guidelines

## Project Structure & Module Organization

This repository builds Alpine-based Docker images for mdBook. The top-level
`Dockerfile` defines the multi-stage image build, and `Makefile` is the primary
entry point for local and CI workflows. Version inputs for mdBook and bundled
preprocessors live in `deps/Cargo.toml`; update `deps/Cargo.lock` with it when
dependency versions change. The `deps/src/main.rs` binary is only a small Rust
helper for dependency/version resolution. The `example/` directory contains a
sample mdBook project, including `book.toml`, Markdown sources in
`example/src/`, Mermaid assets, and `compose.yml`. Project imagery is in
`images/`.

## Build, Test, and Development Commands

- `make setup-buildx`: create and bootstrap a Docker Buildx builder.
- `make build`: build both image variants for the current architecture.
- `make test`: run `mdbook --version` in the Alpine and Rust image variants.
- `make test-build`: build the sample book using the locally built image.
- `make run`: open a shell in the locally built image with `example/` mounted.
- `make compose-build`: run `mdbook build` through `example/compose.yml`.
- `make compose-serve`: serve the example book on ports `3000` and `3001`.

Docker is required for normal validation. CI runs `make build`, `make test`,
`make test-build`, and hadolint for Dockerfile changes.

## Coding Style & Naming Conventions

Keep Makefile targets lowercase and hyphenated, and mark user-facing targets
with `.PHONY`. Use tabs for Makefile recipe lines. Keep Dockerfile instructions
simple, cache-aware, and compatible with hadolint. Shell snippets should quote
variables, prefer explicit image tags, and avoid environment-specific paths.
Rust files in `deps/` should follow standard `rustfmt` formatting.

## Testing Guidelines

There is no standalone unit test suite. Validate behavior through the Docker
workflow: run `make build`, `make test`, and `make test-build` before opening a
PR that changes `Dockerfile`, `Makefile`, or `deps/Cargo.*`. For example book
changes, run `make compose-build`; use `make compose-serve` for manual browser
checks.

## Commit & Pull Request Guidelines

Recent history uses short conventional-style subjects such as `fix(deps): ...`,
`chore(deps): ...`, and `build: ...`. Keep commits focused and use the same
style when practical. PRs should describe the image, dependency, or example
change; mention the commands run; and link related issues or dependency update
PRs. Include screenshots only when documentation or rendered example output
changes visibly.

## Security & Configuration Tips

Do not commit registry credentials. `DOCKER_HUB_TOKEN` and `GITHUB_TOKEN` are
read by `make login` from the environment. When changing base images or Rust
toolchains, keep `Dockerfile`, `Makefile`, and `README.md` examples consistent.
