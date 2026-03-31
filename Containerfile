# Minimal RISC-V (rv64gcv) container with GCC 16 from Debian testing,
# plus build tools for downstream CI.
#
# Build on an x86-64 host with cross-platform support:
#   docker buildx build --platform linux/riscv64 -t ghcr.io/shenki/gcc-riscv64:latest --push .

FROM debian:testing-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       gcc-16 g++-16 \
       cmake ninja-build git ca-certificates python3 \
    && rm -rf /var/lib/apt/lists/*

# Set gcc-16/g++-16 as the default compiler.
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-16 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-16 100

# Smoke test: verify the compiler works and supports the V extension.
RUN gcc --version \
    && echo 'int main(){return 0;}' | g++ -x c++ -march=rv64gcv - -o /dev/null

WORKDIR /work
