#!/usr/bin/env bash
set -exo pipefail

distro="${1}"

# Find URL
url="$(grep -e url "${distro}" | cut -f2 -d'"')"
curl -C - -O "${url}"

# Mount and extract
file=$(printf '%s' "${url}" | sed -E -e 's#.*/(.*)$#\1#')
work="$(mktemp -d)"
xorriso -osirrox on -indev "${file}" -extract / "${work}"

# Modify timeout
chmod -R +w "${work}"
sed -i -e 's/set timeout=.*/set timeout=30/' "${work}/boot/grub/grub.cfg"
sed -i -e 's/timeout.*/timeout 300/' "${work}/isolinux/isolinux.cfg"  # Uses 10ths of a second
chmod -R -w "${work}"

# Create new ISO file
rm "${file}"
chmod +w "${work}/ubuntu" "${work}/isolinux/isolinux.bin"
mkisofs -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V "Boot" -r -iso-level 3 -chrp-boot -o "${file}" "${work}"
new_sum=$(sha256sum "${file}" | cut -f1 -d' ')

# Update distro file
if [ "$(uname)" == "Darwin" ]; then
	SED=$(which gsed)
else
	SED=$(which sed)
fi
"${SED}" -i -e "s/checksum = \".*\"/checksum = \"${new_sum}\"/" "${distro}"
"${SED}" -i -e "s/url = \".*\"/url = \"${file}\"/" "${distro}"
"${SED}" -i -e "s/boot_wait = \".*\"/boot_wait = \"15s\"/" "${distro}"

# Cleanup remaining directories
rm -r "${work}" || true
