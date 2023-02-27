# rustbuilder

A base image for building Rust code, with a bit extra.

## Manually pushing to Docker hub

```shell
docker login

export RUST_TOOLCHAIN=1.67.1
export IMAGE=jameshiew/rustbuilder:$RUST_TOOLCHAIN
docker build \
    --build-arg RUST_TOOLCHAIN=$RUST_TOOLCHAIN \
    --platform linux/arm64 \
    -t $IMAGE-arm64 .
docker push $IMAGE-arm64

docker build \
    --build-arg RUST_TOOLCHAIN=$RUST_TOOLCHAIN \
    --platform linux/amd64 \
    -t $IMAGE-amd64 .
docker push $IMAGE-amd64

docker manifest create $IMAGE \
    --amend $IMAGE-arm64 \
    --amend $IMAGE-amd64
docker manifest push --purge $IMAGE
```
