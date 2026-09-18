/// @description Insert description here
// You can write your code in this editor
offset += ScrollSpeed;
if (offset >= BandWidth)
{
	offset -= BandWidth;
	for (var i = BandCount; i > 0; i--)
	{
		colors[i] = colors[i - 1];
	}
	hue = (hue + 255 * random_range(0.25, 0.75)) mod 255;
	if (count >= (light ? LightCount : DarkCount) && LightCount > 0 && DarkCount > 0)
	{
		count = 0;
		light = !light;
		colors[0] = make_color_hsv(hue, 12, 128);
	}
	else
	{
		colors[0] = make_color_hsv(hue, light ? 16 : 24, light ? 192 : 64);
	}
	count += 1;
}