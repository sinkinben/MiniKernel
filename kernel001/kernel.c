
void kernel_main()
{
	const short color = 0x0F00;
	const char *str = "Hello msg from dummy kernel!";
	short *vga = (short *)0xb8000;
	int i = 0;
	for (i = 0; str[i] != 0; ++i)
		vga[i + 80] = color | str[i];
}
