# define ASM_FILE		1
# include <multiboot.h>

.set ALIGN, 1<<0
.set MEMINFO, 1<<1
.set FLAGS,		ALIGN | MEMINFO
.set MAGIC,		
.set CHECKSUM,	-(MAGIC + FLAGS)

.section .bss, "aw"
	.align 16
stack_bottom:
	.skip 16384
stack_top:

# ifdef HAVE_ASM_USCORE
# define EXT_C(sym)		_ ## sym
# else
# define EXT_C(sym)		sym
# endif

# define STACK_SIZE		0x4000

# ifdef __ELF__
# define AOUT_KLUDGE 0
# else
# define AOUT_KLUDGE MULTIBOOT_AOUT_KLUDGE
# endif

.section .text
.global _start
.type _start, @function
_start:
	jmp	multiboot_entry
	
	.align	8
multiboot_header:
	.long MULTIBOOT2_HEADER_MAGIC
	.long GRUB_MULTIBOOT_ARCHITECTURE_I386
	.long multiboot_header_end - multiboot_header
    .long -(MULTIBOOT2_HEADER_MAGIC + GRUB_MULTIBOOT_ARCHITECTURE_I386 + (multiboot_header_end - multiboot_header))

#ifndef __ELF__
address_tag_start:
	.short MULTIBOOT_HEADER_TAG_ADDRESS
	.short MULTIBOOT_HEADER_TAG_OPTIONAL
	.long address_tag_end - address_tag_start

	.long multiboot_header
	.long _start
	.long _edata
	.long _end
address_tag_end:
entry_address_tag_start:
	.short MULTIBOOT_HEADER_TAG_ENTRY_ADDRESS
	.short MULTIBOOT_HEADER_TAG_OPTIONAL
	.long entry_address_tag_end - entry_address_tag_start
	.long multiboot_entry
entry_address_tag_end:
# endif
framebuffer_tag_start:
	.short MULTIBOOT_HEADER_TAG_FRAMEBUFFER
	.short MULTIBOOT_HEADER_TAG_OPTIONAL
	.long framebuffer_tag_end - framebuffer_tag_start
	.long 1024
	.long 768
	.long 32
framebuffer_tag_end:
	.short MULTIBOOT_HEADER_TAG_END
	.short 0
	.long 8
multiboot_header_end:
multiboot_entry:
	movl	$stack_top, %esp

	pushl	$0
	popf

	pushl	%ebx
	pushl	%eax

	call	kernel_main


	cli
1:	hlt
	jmp 1b
.size _start, . - _start
	
