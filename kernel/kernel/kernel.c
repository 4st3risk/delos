# include <stdio.h>
# include <stdint.h>
# include <kernel/tty.h>
//# include <multiboot.h>

//extern struct multiboot_header _multiboot_header;

void kernel_main () {
//	struct multiboot_header *multiboot_header = &_multiboot_header;
	
//	unsigned size;

	terminal_initialize();
	printf("[+] Terminal Initial Complete\n");
//	if (magic != MULTIBOOT2_BOOTLOADER_MAGIC) {
//		printf("Invalid magic number: 0x%x\n", (unsigned) magic);
//	}
//	if (addr & 7) {
//		printf("Unaligned mbi: 0x%x\n", addr);
//	}

//	size = *(unsigned *) addr;

//	printf("Announces mbi size 0x%x\n", size);

	printf("[+] MultiBoot Enabled\n");
}



