FROM ubuntu:jammy-20230126

RUN apt-get update && apt-get install --no-install-recommends -y \
  ca-certificates \
  clang \
  curl \
  git \
  llvm \
  mold


ENV CARGO_HOME=/usr/local/cargo
ENV CARGO_TARGET_DIR=/usr/local/build/target

ARG RUST_TOOLCHAIN=1.67.1
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --profile minimal --default-toolchain $RUST_TOOLCHAIN

ENV PATH="${CARGO_HOME}/bin:${PATH}"

# more Docker friendly to use CLI git to fetch Cargo crates - see <https://github.com/rust-lang/cargo/issues/10583>
ENV CARGO_NET_GIT_FETCH_WITH_CLI=true
RUN cargo search

WORKDIR /build

COPY config.toml ${CARGO_HOME}/config.toml

RUN cargo install --locked cargo-chef@0.1.51
