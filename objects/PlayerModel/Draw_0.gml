if (showRanges && grid > 1)
{
	draw_set_alpha(0.1);
	draw_set_color(c_black);
	for (var i = 0; i < room_height; i += grid)
	{
		draw_line(0, i, room_width, i);
	}
	for (var i = 0; i < room_width; i += grid)
	{
		draw_line(i, 0, i, room_height);
	}
	draw_set_alpha(1);
}