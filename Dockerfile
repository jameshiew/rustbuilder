FROM ubuntu:jammy-20230126

RUN apt-get update && apt-get install --no-install-recommends -y \
  clang \
  curl \
  git \
  llvm \
  mold

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /build

COPY config.toml /root/.cargo/config.toml

RUN cargo search
RUN cargo install --locked cargo-chef@0.1.51
