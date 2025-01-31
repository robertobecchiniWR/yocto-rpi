UBOOT = $(TOP)/u-boot/qemu-u-boot-bcm-2xxx-rpi4.bin

WIC = build/build/tmp/deploy/images/raspberrypi4-64/core-image-base-raspberrypi4-64.wic

QEMU_OPTS += -machine virt -cpu cortex-a57 -smp 4
QEMU_OPTS += -m 2G
QEMU_OPTS += -bios $(UBOOT)
QEMU_OPTS += -device virtio-net-device,netdev=net0 -netdev user,id=net0
QEMU_OPTS += -drive id=disk0,file=$(WIC),if=none,format=raw -device virtio-blk-device,drive=disk0
#QEMU_OPTS += -device qemu-xhci
QEMU_OPTS += -nographic
#QEMU_OPTS += -device virtio-gpu-pci
#QEMU_OPTS += -serial stdio
#QEMU_OPTS += -device usb-tablet -device usb-kbd

qemu-start: $(WIC)
	qemu-system-aarch64 $(QEMU_OPTS)
