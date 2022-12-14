#!/bin/bash

CHROOT_DIR="/opt/ANDRAX/"
hostname ANDRAX-Hackers-Platform
mkdir ${CHROOT_DIR} > /dev/null 2>&1
if [[ -e ${CHROOT_DIR}/bin/bash ]]; then
	cd ${CHROOT_DIR}
	mkdir proc > /dev/null 2>&1
	mkdir dev > /dev/null 2>&1
	mkdir sys > /dev/null 2>&1

	if [[ ! -e "/dev/fd" || ! -e "/dev/stdin" || ! -e "/dev/stdout" || ! -e "/dev/stderr" ]]; then
		[[ -e "/dev/fd" ]] || ln -s /proc/self/fd /dev/
		[[ -e "/dev/stdin" ]] || ln -s /proc/self/fd/0 /dev/stdin
		[[ -e "/dev/stdout" ]] || ln -s /proc/self/fd/1 /dev/stdout
		[[ -e "/dev/stderr" ]] || ln -s /proc/self/fd/2 /dev/stderr
	fi

	if [[ ! -e "/dev/tty0" ]]; then

	    ln -s /dev/null /dev/tty0 > /dev/null 2>&1

	fi

	if [[ ! -e "/dev/net/tun" ]]; then

	    [[ -d "/dev/net" ]] || mkdir -p /dev/net > /dev/null 2>&1
	    mknod /dev/net/tun c 10 200 > /dev/null 2>&1

	fi

	mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc > /dev/null 2>&1

	mount --bind /proc proc/ > /dev/null 2>&1
	mount --bind /dev dev/ > /dev/null 2>&1
	mount --bind /sys sys/ > /dev/null 2>&1

	mkdir -p /dev/shm > /dev/null 2>&1
	mount -o rw,nosuid,nodev,mode=1777 -t tmpfs tmpfs /dev/shm > /dev/null 2>&1
	mount -o bind /dev/shm dev/shm > /dev/null 2>&1

	mount -o bind /dev/pts dev/pts > /dev/null 2>&1

	mkdir ${CHROOT_DIR}/run/sshd ${CHROOT_DIR}/var/run/sshd > /dev/null 2>&1

	mknod /dev/null c 1 3
	chmod 666 /dev/null

	export TERM="xterm-256color"
	mkdir ${CHROOT_DIR}/run/sshd ${CHROOT_DIR}/var/run/sshd > /dev/null 2>&1
	unset TMP TEMP TMPDIR LD_PRELOAD LD_DEBUG
	chroot ${CHROOT_DIR} /bin/su - andrax


else

	cd /opt
	echo "Downloading core"
	wget https://gitlab.com/crk-mythical/andrax-hackers-platform-v5-2/-/blob/master/compressed-core/andrax.r5-build5.tar.xz

	echo "Extracting this shit"
	sudo tar --same-owner -p -h -xvJf andrax.r5-build5.tar.xz -C /opt/ANDRAX/

	cd ${CHROOT_DIR}

	mkdir proc > /dev/null 2>&1
	mkdir dev > /dev/null 2>&1
	mkdir sys > /dev/null 2>&1

	if [[ ! -e "/dev/fd" || ! -e "/dev/stdin" || ! -e "/dev/stdout" || ! -e "/dev/stderr" ]]; then
		[[ -e "/dev/fd" ]] || ln -s /proc/self/fd /dev/
		[[ -e "/dev/stdin" ]] || ln -s /proc/self/fd/0 /dev/stdin
		[[ -e "/dev/stdout" ]] || ln -s /proc/self/fd/1 /dev/stdout
		[[ -e "/dev/stderr" ]] || ln -s /proc/self/fd/2 /dev/stderr
	fi

	if [[ ! -e "/dev/tty0" ]]; then

	    ln -s /dev/null /dev/tty0 > /dev/null 2>&1

	fi

	if [[ ! -e "/dev/net/tun" ]]; then

	    [[ -d "/dev/net" ]] || mkdir -p /dev/net > /dev/null 2>&1
	    mknod /dev/net/tun c 10 200 > /dev/null 2>&1

	fi

	mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc > /dev/null 2>&1

	mount --bind /proc proc/ > /dev/null 2>&1
	mount --bind /dev dev/ > /dev/null 2>&1
	mount --bind /sys sys/ > /dev/null 2>&1

	mkdir -p /dev/shm > /dev/null 2>&1
	mount -o rw,nosuid,nodev,mode=1777 -t tmpfs tmpfs /dev/shm > /dev/null 2>&1
	mount -o bind /dev/shm dev/shm > /dev/null 2>&1

	mount -o bind /dev/pts dev/pts > /dev/null 2>&1

	mkdir ${CHROOT_DIR}/run/sshd ${CHROOT_DIR}/var/run/sshd > /dev/null 2>&1

	mknod /dev/null c 1 3
	chmod 666 /dev/null

	export TERM="xterm-256color"
	mkdir ${CHROOT_DIR}/run/sshd ${CHROOT_DIR}/var/run/sshd > /dev/null 2>&1
	unset TMP TEMP TMPDIR LD_PRELOAD LD_DEBUG
	chroot ${CHROOT_DIR} /bin/su - andrax
fi
