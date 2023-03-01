# rustbuilder [![Docker Hub pulls](https://img.shields.io/docker/pulls/jameshiew/rustbuilder?style=flat-square)](https://hub.docker.com/r/jameshiew/rustbuilder/tags)

A base image for building Rust code, that should be less intensive than the default Rust images.

- based off official [rust:slim-bookworm](https://hub.docker.com/_/rust) Docker image
- built for `linux/arm64` and `linux/amd64` platforms
- uses [`mold`](https://github.com/rui314/mold) for linking
- makes Cargo use native git rather than libgit2, to workaround <https://github.com/rust-lang/cargo/issues/10583>
- includes a prebuilt [cargo-chef](https://github.com/LukeMathWalker/cargo-chef) binary for cooking from recipe.json files

The build output `target/` directory is `/usr/local/build/target`.
