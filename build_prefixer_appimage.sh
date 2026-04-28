
set -eux

ARCH="$(uname -m)"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

export ICON=DUMMY
export DESKTOP=DUMMY
export OUTPATH=/dist
export MAIN_BIN=prefixer
export OUTNAME=prefixer-"$ARCH".AppImage
export DEPLOY_PYTHON=1

pacman -Syu --noconfirm \
	base-devel       \
	curl             \
	git              \
	wget             \
	xorg-server-xvfb \
	zsync \
	python-pip


echo "Installing app via pip..."
echo "---------------------------------------------------------------"

pip install prefixer --break-system-packages

echo "Bundling AppImage..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
./quick-sharun /usr/bin/prefixer

./quick-sharun --make-appimage
