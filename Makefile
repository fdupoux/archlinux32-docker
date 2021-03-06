all: clean
	$(eval TEMPDIR := $(shell mktemp -d))
	$(eval CURTIME := $(shell date +%Y%m%d-%H%M))
	pacman -Sy --noconfirm archlinux32-keyring
	env -i setarch i686 pacstrap -C rootfs/etc/pacman.conf -c -d -G -M $(TEMPDIR) $(shell cat packages)
	cp --recursive --preserve=timestamps --backup --suffix=.pacnew rootfs/* $(TEMPDIR)/
	arch-chroot $(TEMPDIR) locale-gen
	arch-chroot $(TEMPDIR) pacman-key --init
	arch-chroot $(TEMPDIR) pacman-key --populate archlinux32
	tar --numeric-owner --xattrs --acls --exclude-from=exclude -C $(TEMPDIR) -z -c . -f archlinux32.tar.gz
	rm -rf $(TEMPDIR)
	docker build -t fdupoux/archlinux32:$(CURTIME) -t fdupoux/archlinux32:latest .
	rm -f archlinux32.tar.gz

clean:
	rm -f archlinux32.tar.gz
