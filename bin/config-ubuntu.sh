#!/usr/bin/env bash

NVIDIA_VERSION=470
#NVIDIA_VARIANT="-server"
AMD_VERSION=21.30
OPENJDK_JRE_VERSION=17

apt update && apt upgrade

# Install essentials
apt install silversearcher-ag vim

# Install nvidia headless drivers
# TODO: Check for server vs. desktop install
apt install nvidia-headless-"${NVIDIA_VERSION}${NVIDIA_VARIANT}"

# TODO: Grab AMD driver and install

# Ensure AMD overclocking is enabled
AMD_OC_ENABLED=$(grep 'amdgpu.ppfeaturemask' /etc/default/grub)
[ -z "${AMD_OC_ENABLED}" ] \
	&& echo 'GRUB_CMDLINE_LINUX_DEFAULT="${GRUB_CMDLINE_LINUX_DEFAULT} amdgpu.ppfeaturemask=0xffffffff"' >> /etc/default/grub \
	&& sudo update-grub && sudo update-grub2 && sudo update-initramfs -u -k all \
	|| echo "AMD overclock mask already set: ${AMD_OC_ENABLED}"

# Install java for minecraft server...
apt install openjdk-17-jre-headless

# TODO: Clone other repos etc

