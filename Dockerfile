# syntax=docker/dockerfile:1
#
LABEL org.opencontainers.image.source=https://github.com/srappan/vsjetpack-plugin-container
FROM archlinux:base-devel AS build

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    NVIDIA_DRIVER_CAPABILITIES=all \
    NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all \
    CUDA_PATH=/opt/cuda  \
    PATH=$PATH:/opt/cuda/bin/nvcc \
    PATH=$PATH:/opt/cuda/bin \
    LD_LIBRARY_PATH=/opt/cuda/lib64 \
    PKGEXT=".pkg.tar" \
    PKGDEST="/home/vsuser/plugin_pkgs"

RUN pacman-key --init \
    && pacman-key --populate archlinux

RUN pacman -Syu --noconfirm --needed \
    git \
    python \
    vapoursynth \
    ffmpeg \
    libxml2-legacy \
    cuda \
    go \
    cargo \
    ffms2 \
    cmake \
    ninja \
    python-uv-build \
    uv \
    boost \
    meson \
    nasm \ 
    zig \
    onetbb \
    gsl \
    opencl-headers \
    llvm \
    intel-oneapi-mkl \
    unzip \
    && pacman -Scc --noconfirm
RUN source /etc/profile

RUN useradd -m -G wheel vsuser && passwd -d vsuser && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 
# echo "vsuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# RUN echo 'vsuser ALL=NOPASSWD: ALL' >> /etc/sudoer
# RUN sed -Ei 's/^#\ (%wheel.*NOPASSWD.*)/\1/' /etc/sudoers
USER vsuser
WORKDIR /home/vsuser


RUN git clone https://aur.archlinux.org/vapoursynth-plugin-nlm-cuda-git.git && \
    cd vapoursynth-plugin-nlm-cuda-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-mvtools-git.git && \
    cd vapoursynth-plugin-mvtools-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-vszip.git && \
    cd vapoursynth-plugin-vszip && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-zsmooth-git.git && \
    cd vapoursynth-plugin-zsmooth-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-bestsource-git.git && \
    cd vapoursynth-plugin-bestsource-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/foosynth-plugin-neo_f3kdb-git.git && \
    cd foosynth-plugin-neo_f3kdb-git && \
    sed -i "/avisynth-plugin-\${_plug}-git/d" PKGBUILD && \
    sed -i "/avisynthplus/d" PKGBUILD && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-misc-git.git && \
    cd vapoursynth-plugin-misc-git && \
    makepkg --noconfirm && \
    rm -rf /home/vsuser/plugin_pkgs/*-debug*.pkg.tar

WORKDIR /home/vsuser
USER root
RUN pacman -U --noconfirm ${PKGDEST}/vapoursynth-plugin-misc-git*.pkg.tar
USER vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-ttempsmooth-git.git && \
    cd vapoursynth-plugin-ttempsmooth-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-bore-git.git && \
    cd vapoursynth-plugin-bore-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-knlmeanscl-git.git && \
    cd vapoursynth-plugin-knlmeanscl-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-vsakarin-git.git && \
    cd vapoursynth-plugin-vsakarin-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
# RUN git clone https://aur.archlinux.org/vapoursynth-plugin-bm3dhip-git.git && \
#     cd vapoursynth-plugin-bm3dhip-git && \
#     makepkg --noconfirm 
# WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-bm3dcuda-git.git && \
    cd vapoursynth-plugin-bm3dcuda-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-fmtconv.git && \
    cd vapoursynth-plugin-fmtconv && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-addnoise-git.git && \
    cd vapoursynth-plugin-addnoise-git && \
    sed -i "/ -\p build/i sed -i "s/\+\=/=/g" */meson.build" PKGBUILD && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-fft3dfilter-git.git && \
    cd vapoursynth-plugin-fft3dfilter-git && \
    makepkg --noconfirm 
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-adaptivegrain-git.git && \
    cd vapoursynth-plugin-adaptivegrain-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-dfttest2-git.git && \
    cd vapoursynth-plugin-dfttest2-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-nnedi3_weights_bin.git && \
    cd vapoursynth-plugin-nnedi3_weights_bin && \
    makepkg --noconfirm
WORKDIR /home/vsuser
USER root
RUN pacman -U --noconfirm ${PKGDEST}/vapoursynth-plugin-nnedi3_weights_bin*.pkg.tar
USER vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-znedi3-git.git && \
    cd vapoursynth-plugin-znedi3-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-eedi3m-git.git && \
    cd vapoursynth-plugin-eedi3m-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-fpng-git.git && \
    cd vapoursynth-plugin-fpng-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-vivtc-git.git && \
    cd vapoursynth-plugin-vivtc-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-tedgemask-git.git && \
    cd vapoursynth-plugin-tedgemask-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-scxvid-git.git && \
    cd vapoursynth-plugin-scxvid-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-sangnom-git.git && \
    cd vapoursynth-plugin-sangnom-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-retinex-git.git && \
    cd vapoursynth-plugin-retinex-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-wnnm-git.git && \
    cd vapoursynth-plugin-wnnm-git && \
    # sed -i "/python-pip/d" PKGBUILD && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-wwxd-git.git && \
    cd vapoursynth-plugin-wwxd-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-dctfilter-git.git && \
    cd vapoursynth-plugin-dctfilter-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-bilateralgpu-git.git && \
    cd vapoursynth-plugin-bilateralgpu-git && \
    sed -i "/nvidia-utils/d" PKGBUILD && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN git clone https://aur.archlinux.org/vapoursynth-plugin-d2vsource-git.git && \
    cd vapoursynth-plugin-d2vsource-git && \
    makepkg --noconfirm
WORKDIR /home/vsuser
RUN rm -rf /home/vsuser/plugin_pkgs/*-debug*.pkg.tar

# RUN git clone https://aur.archlinux.org/python-pyparsebluray-git.git && \
#     cd python-pyparsebluray-git && \
#     makepkg --noconfirm
# WORKDIR /home/vsuser
# RUN git clone https://aur.archlinux.org/vapoursynth-plugin-vodesfunc-git.git && \
#     cd vapoursynth-plugin-vodesfunc-git && \
#     makepkg --noconfirm 
# WORKDIR /home/vsuser
# USER root
# WORKDIR /home/vsuser/

FROM archlinux:latest AS final

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONUNBUFFERED=1 \
    NVIDIA_DRIVER_CAPABILITIES=all \
    NVIDIA_VISIBLE_DEVICES=nvidia.com/gpu=all \
    CUDA_PATH=/opt/cuda  \
    PATH=$PATH:/opt/cuda/bin/nvcc \
    PATH=$PATH:/opt/cuda/bin \
    LD_LIBRARY_PATH=/opt/cuda/lib64 \
    PKGEXT=".pkg.tar" 

RUN pacman-key --init \
    && pacman-key --populate archlinux
RUN pacman -Syu --noconfirm --needed \
    python \
    vapoursynth \
    ffmpeg \
    ffms2 \
    libxml2-legacy \
    cuda \
    onetbb \
    gsl \
    llvm-libs \
    && pacman -Scc --noconfirm
RUN source /etc/profile
COPY --from=build /home/vsuser/*/*.pkg.tar plugin_pkgs/
RUN pacman --noconfirm -U --needed */*.pkg.tar
# RUN echo "PKGEXT='.pkg.tar'" >> /home/vsuser/.makepkg.conf

# USER vsuser

# RUN yay -S --noconfirm \
#     python-typed-ffmpeg-compatible \
#     python-mkvinfo \ 
#     python-msgspec 

# RUN yay -S --noconfirm \
#     vapoursynth-plugin-vsjetpack \
#     vapoursynth-plugin-mvtools \
#     vapoursynth-plugin-vszip \
#     vapoursynth-plugin-zsmooth-git \
#     vapoursynth-plugin-bestsource \
#     vapoursynth-plugin-neo_f3kdb-git \
#     vapoursynth-plugin-ttempsmooth-git \
#     vapoursynth-plugin-bore-git \
#     vapoursynth-plugin-nlm-cuda-git \
#     # vapoursynth-plugin-knlmeanscl-git \
#     vapoursynth-plugin-vodesfunc-git \
#     vapoursynth-plugin-vsakarin-git \
#     # vapoursynth-plugin-bm3dhip-git \
#     vapoursynth-plugin-bm3dcuda-git \
#     && yay -Scc --noconfirm

