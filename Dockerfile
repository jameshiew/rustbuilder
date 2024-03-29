ARG RUST_VERSION=1.68
FROM rust:${RUST_VERSION}-slim-bookworm AS base

RUN apt-get update && apt-get install --no-install-recommends -y \
  ca-certificates \
  clang \
  curl \
  git \
  libpq-dev \
  libssl-dev \
  llvm \
  pkg-config \
  mold

ENV CARGO_TARGET_DIR=/usr/local/build/target

# more Docker friendly to use CLI git to fetch Cargo crates
# see <https://github.com/rust-lang/cargo/issues/10583>
ENV CARGO_NET_GIT_FETCH_WITH_CLI=true
ENV CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
RUN cargo search

WORKDIR /build

COPY config.toml ${CARGO_HOME}/config.toml

FROM base AS cargo-chef-installer

RUN cargo install --locked cargo-chef@0.1.51

FROM base

COPY --from=cargo-chef-installer ${CARGO_HOME}/bin/cargo-chef ${CARGO_HOME}/bin/cargo-chef