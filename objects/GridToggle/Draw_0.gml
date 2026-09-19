draw_self();
if (value <= 1)
{
	draw_set_color(make_colour_rgb(255, 127, 127));
	draw_line_width(x + 11, y + 11, x - 12, y - 12, 8);
	draw_line_width(x + 11, y - 12, x - 12, y + 11, 8);
}
else
{
	draw_set_color(c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, y, string(value));
}
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(x + 20, y, label);