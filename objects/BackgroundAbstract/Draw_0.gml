/// @description Insert description here
// You can write your code in this editor
draw_set_alpha(1);
for (var i = 0; i <= BandCount; i++)
{
	draw_set_color(colors[i]);
	var x0 = OrigX + (i * BandWidth + offset - BandWidth) * RightRate;
	var x1 = OrigX + (i * BandWidth + offset) * RightRate;
	var y0 = OrigY + (i * BandWidth + offset - BandWidth) * DownRate;
	var y1 = OrigY + (i * BandWidth + offset) * DownRate;
	draw_triangle(x0, OrigY - DownRate, x1, OrigY - DownRate, OrigX - RightRate, y0, false);
	draw_triangle(x1, OrigY - DownRate, OrigX - RightRate, y0, OrigX - RightRate, y1, false);
}