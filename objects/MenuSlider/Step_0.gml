if (holding)
{
	value = clamp((mouse_x - x + 50) / 100, 0, 1);
	sliderfunction(func, value);
}