# vsjetpack-plugin-container
AIO container with Vapoursynth plugins built using AUR for vsjetpack. For use with Docker, Podman, DistroBox etc. (The rest you can install via pip/uv on your host)

## TODO
- [x] [Nvidia CUDA/TRT](ghcr.io/srappan/vsjetpack/nvidia) support. [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/index.html) is required to be installed and setup for your container orchestrator.
  - [ ] Install vs-mlrt (either build it or download binaries via Github Actions on vs-mlrt repo)
- [ ] AMD HIP/RoCM support
- [ ] Intel GPU support
- [ ] Make it less bloat
- [ ] Rootless?
