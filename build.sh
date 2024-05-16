#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-kinoite}"
BASE_IMAGE_FLAVOR="${BASE_IMAGE_FLAVOR:-main}"
IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
KERNEL_FLAVOR="${KERNEL_FLAVOR:-fsync}"
IMAGE_BRANCH="${IMAGE_BRANCH:-main}"
SOURCE_IMAGE="${SOURCE_IMAGE:-$BASE_IMAGE_NAME-$BASE_IMAGE_FLAVOR}"
BASE_IMAGE="ghcr.io/ublue-os/${SOURCE_IMAGE}"
FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

IMAGE_NAME="${IMAGE_NAME:-bazzite}"
IMAGE_VENDOR="${IMAGE_VENDOR:-ublue-os}"
IMAGE_FLAVOR="${IMAGE_FLAVOR:-main}"
KERNEL_FLAVOR="${KERNEL_FLAVOR:-fsync}"
IMAGE_BRANCH="${IMAGE_BRANCH:-main}"
BASE_IMAGE_NAME="${BASE_IMAGE_NAME:-kinoite}"
FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"

cp system_files/desktop/shared system_files/desktop/${BASE_IMAGE_NAME} /

# Setup Copr repos


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install screen

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
