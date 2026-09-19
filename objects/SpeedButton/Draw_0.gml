draw_self();
draw_set_color(c_dkgray);
if (value <= 0)
{
	draw_line_width(x + 27, y + 39, x + 27, y - 40, 24);
	draw_line_width(x - 28, y + 39, x - 28, y - 40, 24);
}
else if (value <= 1)
{
	draw_line_width(x - 20, y + 40, x + 20, y + 0, 24);
	draw_line_width(x - 20, y - 40, x + 20, y + 0, 24);
	draw_circle(x + 20, y + 0, 12, false);
}
else if (value <= 2)
{
	draw_line_width(x - 35, y + 40, x - 5, y + 0, 24);
	draw_line_width(x - 35, y - 40, x - 5, y + 0, 24);
	draw_circle(x - 5, y + 0, 12, false);
	draw_line_width(x + 5, y + 40, x + 35, y + 0, 24);
	draw_line_width(x + 5, y - 40, x + 35, y + 0, 24);
	draw_circle(x + 35, y + 0, 12, false);
}
else
{
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, y, "x" + string(value));
}