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


# Setup Copr repos
curl -Lo /usr/bin/copr https://raw.githubusercontent.com/ublue-os/COPR-command/main/copr && \
chmod +x /usr/bin/copr && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-bazzite.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-bazzite-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-bazzite-multilib.repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-bazzite-multilib-fedora-"${FEDORA_MAJOR_VERSION}".repo?arch=x86_64 && \
curl -Lo /etc/yum.repos.d/_copr_ublue-os-staging.repo https://copr.fedorainfracloud.org/coprs/ublue-os/staging/repo/fedora-"${FEDORA_MAJOR_VERSION}"/ublue-os-staging-fedora-"${FEDORA_MAJOR_VERSION}".repo?arch=x86_64 && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-system76-scheduler.repo https://copr.fedorainfracloud.org/coprs/kylegospo/system76-scheduler/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-system76-scheduler-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-latencyflex.repo https://copr.fedorainfracloud.org/coprs/kylegospo/LatencyFleX/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-LatencyFleX-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-obs-vkcapture.repo https://copr.fedorainfracloud.org/coprs/kylegospo/obs-vkcapture/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-obs-vkcapture-fedora-"${FEDORA_MAJOR_VERSION}".repo?arch=x86_64 && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-wallpaper-engine-kde-plugin.repo https://copr.fedorainfracloud.org/coprs/kylegospo/wallpaper-engine-kde-plugin/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-wallpaper-engine-kde-plugin-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-vk_hdr_layer.repo https://copr.fedorainfracloud.org/coprs/kylegospo/vk_hdr_layer/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-vk_hdr_layer-fedora-"${FEDORA_MAJOR_VERSION}".repo?arch=x86_64 && \
curl -Lo /etc/yum.repos.d/_copr_ycollet-audinux.repo https://copr.fedorainfracloud.org/coprs/ycollet/audinux/repo/fedora-"${FEDORA_MAJOR_VERSION}"/ycollet-audinux-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-rom-properties.repo https://copr.fedorainfracloud.org/coprs/kylegospo/rom-properties/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-rom-properties-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-joycond.repo https://copr.fedorainfracloud.org/coprs/kylegospo/joycond/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-joycond-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_kylegospo-webapp-manager.repo https://copr.fedorainfracloud.org/coprs/kylegospo/webapp-manager/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-webapp-manager-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_hhd-dev-hhd.repo https://copr.fedorainfracloud.org/coprs/hhd-dev/hhd/repo/fedora-"${FEDORA_MAJOR_VERSION}"/hhd-dev-hhd-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_che-nerd-fonts.repo https://copr.fedorainfracloud.org/coprs/che/nerd-fonts/repo/fedora-"${FEDORA_MAJOR_VERSION}"/che-nerd-fonts-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_sentry-switcheroo-control_discrete.repo https://copr.fedorainfracloud.org/coprs/sentry/switcheroo-control_discrete/repo/fedora-"${FEDORA_MAJOR_VERSION}"/sentry-switcheroo-control_discrete-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_hikariknight-looking-glass-kvmfr.repo https://copr.fedorainfracloud.org/coprs/hikariknight/looking-glass-kvmfr/repo/fedora-"${FEDORA_MAJOR_VERSION}"/hikariknight-looking-glass-kvmfr-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_mavit-discover-overlay.repo https://copr.fedorainfracloud.org/coprs/mavit/discover-overlay/repo/fedora-"${FEDORA_MAJOR_VERSION}"/mavit-discover-overlay-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_matte-schwartz-sunshine.repo https://copr.fedorainfracloud.org/coprs/matte-schwartz/sunshine/repo/fedora-"${FEDORA_MAJOR_VERSION}"/matte-schwartz-sunshine-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_rok-cdemu.repo https://copr.fedorainfracloud.org/coprs/rok/cdemu/repo/fedora-"${FEDORA_MAJOR_VERSION}"/rok-cdemu-fedora-"${FEDORA_MAJOR_VERSION}".rep && \
curl -Lo /etc/yum.repos.d/_copr_rodoma92-kde-cdemu-manager.repo https://copr.fedorainfracloud.org/coprs/rodoma92/kde-cdemu-manager/repo/fedora-"${FEDORA_MAJOR_VERSION}"/rodoma92-kde-cdemu-manager-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/_copr_rodoma92-rmlint.repo https://copr.fedorainfracloud.org/coprs/rodoma92/rmlint/repo/fedora-"${FEDORA_MAJOR_VERSION}"/rodoma92-rmlint-fedora-"${FEDORA_MAJOR_VERSION}".repo && \
curl -Lo /etc/yum.repos.d/tailscale.repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
sed -i 's@gpgcheck=1@gpgcheck=0@g' /etc/yum.repos.d/tailscale.repo && \
ostree container commit

# Setup firmware
mkdir -p /tmp/mediatek-firmware && \
curl -Lo /tmp/mediatek-firmware/WIFI_MT7922_patch_mcu_1_1_hdr.bin https://gitlab.com/kernel-firmware/linux-firmware/-/raw/8f08053b2a7474e210b03dbc2b4ba59afbe98802/mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin?inline=false && \
curl -Lo /tmp/mediatek-firmware/WIFI_RAM_CODE_MT7922_1.bin https://gitlab.com/kernel-firmware/linux-firmware/-/raw/8f08053b2a7474e210b03dbc2b4ba59afbe98802/mediatek/WIFI_RAM_CODE_MT7922_1.bin?inline=false && \
xz --check=crc32 /tmp/mediatek-firmware/WIFI_MT7922_patch_mcu_1_1_hdr.bin && \
xz --check=crc32 /tmp/mediatek-firmware/WIFI_RAM_CODE_MT7922_1.bin && \
mv -vf /tmp/mediatek-firmware/* /usr/lib/firmware/mediatek/ && \
rm -rf /tmp/mediatek-firmware && \
mkdir -p /tmp/linux-firmware-neptune && \
curl -Lo /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-cali.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/cs35l41-dsp1-spk-cali.bin && \
curl -Lo /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-cali.wmfw https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/cs35l41-dsp1-spk-cali.wmfw && \
curl -Lo /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-prot.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/cs35l41-dsp1-spk-prot.bin && \
curl -Lo /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-prot.wmfw https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/cs35l41-dsp1-spk-prot.wmfw && \
xz --check=crc32 /tmp/linux-firmware-neptune/cs35l41-dsp1-spk-{cali.bin,cali.wmfw,prot.bin,prot.wmfw} && \
mv -vf /tmp/linux-firmware-neptune/* /usr/lib/firmware/cirrus/ && \
rm -rf /tmp/linux-firmware-neptune && \
mkdir -p /tmp/linux-firmware-galileo && \
curl https://gitlab.com/evlaV/linux-firmware-neptune/-/archive/jupiter-20231113.1/linux-firmware-neptune-jupiter-20231113.1.tar.gz?path=ath11k/QCA206X -o /tmp/linux-firmware-galileo/ath11k.tar.gz && \
tar --strip-components 1 --no-same-owner --no-same-permissions --no-overwrite-dir -xvf /tmp/linux-firmware-galileo/ath11k.tar.gz -C /tmp/linux-firmware-galileo && \
xz --check=crc32 /tmp/linux-firmware-galileo/ath11k/QCA206X/hw2.1/* && \
mv -vf /tmp/linux-firmware-galileo/ath11k/QCA206X /usr/lib/firmware/ath11k/QCA206X && \
rm -rf /tmp/linux-firmware-galileo/ath11k && \
rm -rf /tmp/linux-firmware-galileo/ath11k.tar.gz && \
curl -Lo /tmp/linux-firmware-galileo/hpbtfw21.tlv https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/qca/hpbtfw21.tlv && \
curl -Lo /tmp/linux-firmware-galileo/hpnv21.309 https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/qca/hpnv21.309 && \
curl -Lo /tmp/linux-firmware-galileo/hpnv21.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/qca/hpnv21.bin && \
curl -Lo /tmp/linux-firmware-galileo/hpnv21g.309 https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/qca/hpnv21g.309 && \
curl -Lo /tmp/linux-firmware-galileo/hpnv21g.bin https://gitlab.com/evlaV/linux-firmware-neptune/-/raw/jupiter-20231113.1/qca/hpnv21g.bin && \
xz --check=crc32 /tmp/linux-firmware-galileo/* && \
mv -vf /tmp/linux-firmware-galileo/* /usr/lib/firmware/qca/ && \
rm -rf /tmp/linux-firmware-galileo && \
rm -rf /usr/share/alsa/ucm2/conf.d/acp5x/Valve-Jupiter-1.conf && \
if [[ "${IMAGE_FLAVOR}" =~ "asus" ]]; then \
    curl -Lo /etc/yum.repos.d/_copr_lukenukem-asus-linux.repo https://copr.fedorainfracloud.org/coprs/lukenukem/asus-linux/repo/fedora-$(rpm -E %fedora)/lukenukem-asus-linux-fedora-$(rpm -E %fedora).repo && \
    rpm-ostree install \
        asusctl \
        asusctl-rog-gui && \
    git clone https://gitlab.com/asus-linux/firmware.git --depth 1 /tmp/asus-firmware && \
    cp -rf /tmp/asus-firmware/* /usr/lib/firmware/ && \
    rm -rf /tmp/asus-firmware \
; fi && \
ostree container commit

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
