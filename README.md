# GCC 16 RISC-V Container

Container image with GCC 16 from Debian testing for RISC-V CI.

 - `gcc-16` / `g++-16` from Debian testing, set as the default `gcc`/`g++`
 - `cmake`, `ninja-build`, `git`, `python3`
 - Based on `debian:testing-slim`


Published to `ghcr.io/shenki/gcc-riscv64`.

## Building

The image targets `linux/riscv64`. Build it on an x86-64 host using QEMU
emulation:

```
docker buildx build --platform linux/riscv64 -t ghcr.io/shenki/gcc-riscv64:latest --push .
```

Or with kaniko:

```
/kaniko/executor --custom-platform linux/riscv64 --context . --dockerfile Containerfile \
  --destination ghcr.io/shenki/gcc-riscv64:latest
```

A GitHub Actions workflow (`.github/workflows/build.yml`) automates this via
manual dispatch.
