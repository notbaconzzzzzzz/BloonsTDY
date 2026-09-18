/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_black);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(100, 20, "$"+string(money))
draw_text(40, 40, "Lives: "+string(lifes))
draw_set_circle_precision(48);

if (tryingtobuytower)
{
	var tx = tryingtobuytowertx;
	var ty = tryingtobuytowerty;
	draw_set_color(make_color_rgb(192, 128, 32));
	draw_set_alpha(0.5);
	draw_circle(tx, ty, 30-0.5, false);
	if (tryingtobuytowervalidposition) draw_set_color(c_black);
	else draw_set_color(c_red);
	draw_set_alpha(0.2);
	draw_circle(tx, ty, 20*9, false);
	draw_set_alpha(1);
}