#!/usr/bin/env bash
set -exo pipefail

distro="${1}"

# Find URL
url="$(cat "${distro}" | grep url | cut -f2 -d'"')"
curl -C - -O "${url}"

# Mount and copy
file=$(printf "${url}" | sed -E -e 's#.*/(.*)$#\1#')
old=$(mktemp -d)
new=$(mktemp -d)
if [ "$(uname)" == "Darwin" ]; then
	hdiutil attach -mountpoint "${old}" "${file}"
else
	sudo mount -t iso9660 -o loop "${file}" "${old}"
fi
{
	cd "${old}"
	tar -cvf - . | (cd "${new}" && tar -xf -)
	cd -
}

# Modify timeout
chmod +w "${new}/boot/grub" "${new}/boot/grub/grub.cfg"
chmod +w "${new}/isolinux" "${new}/isolinux/isolinux.cfg"
sed -i -e 's/set timeout=.*/set timeout=30/' "${new}/boot/grub/grub.cfg"
sed -i -e 's/timeout.*/timeout 300/' "${new}/isolinux/isolinux.cfg"  # Uses 10ths of a second
chmod -w "${new}/boot/grub" "${new}/boot/grub/grub.cfg"
chmod -w "${new}/isolinux" "${new}/isolinux/isolinux.cfg"
cat "${new}/boot/grub/grub.cfg"
cat "${new}/isolinux/isolinux.cfg"

# Create new ISO file
if [ "$(uname)" == "Darwin" ]; then
	hdiutil unmount "${old}"
else
	sudo umount "${old}"
fi
rm "${file}"
chmod +w "${new}/isolinux/isolinux.bin"
mkisofs -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V "Boot" -r -iso-level 4 -chrp-boot -o "${file}" "${new}"
new_sum=$(sha256sum "${file}" | cut -f1 -d' ')

# Update distro file
sed -i "${distro}" -e "s/checksum = \".*\"/checksum = \"${new_sum}\"/"
sed -i "${distro}" -e "s/url = \".*\"/url = \"${file}\"/"
sed -i "${distro}" -e "s/boot_wait = \".*\"/boot_wait = \"15s\"/"

# Cleanup remaining directories
rm -r "${old}"
#sudo rm -r "${new}"
