%define KERNEL_START             0xC0000000

        extern kmain
        global _start

        section .text 
_start:
        cli
        mov     esp, KERNEL_START + 0x10000

        ; Jump to C: kernel main func
        jmp     kmain