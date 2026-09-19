draw_self();
if (toggled)
{
	draw_set_color(c_green);
	draw_line_width(x - 12, y - 0, x - 4, y + 8, 8);
	draw_line_width(x + 12, y - 12, x - 4, y + 8, 8);
	draw_circle(x - 4, y + 8, 4, false);
}
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(x + 20, y, label);