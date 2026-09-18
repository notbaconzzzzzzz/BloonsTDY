/// @description Insert description here
// You can write your code in this editor
if (!needsredraw)
{
	draw_self();
	return;
}
draw_set_color(make_color_hsv(30*255/360, 64, 128));
drawpaths(60);
draw_set_color(make_color_hsv(30*255/360, 64, 192));
drawpaths(54);