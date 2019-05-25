#include <lib/root.h>
#include <vga/vga.h>
#include <lib/stdio.h>

int kmain() 
{
    char *vga_base = (char*)0xC00B8000;
    char *vga_low = (char *)0xB8000;
    vga_low[0] = 'X';
    vga_low[1] = 0x0C;

    char *vga_high = (char *)0xC00B8000;
    vga_high[2] = 'Y';
    vga_high[3] = 0x0C;

    vga_base[160] = '!';
    vga_base[161] = 0x0c;

    vga_init();
    vga_puts("Hello");
    vga_puts("World");

    printf_test();
    while (1);
    return 0;
}
