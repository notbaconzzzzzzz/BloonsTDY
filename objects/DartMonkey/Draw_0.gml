/// @description Insert description here
// You can write your code in this editor
draw_set_circle_precision(48);
draw_set_alpha(1);
draw_set_color(make_color_rgb(192*0.75, 128*0.66666, 32*0.5));
draw_circle(x, y, 30-0.5, false);
draw_set_color(make_color_rgb(192, 128, 32));
draw_circle(x, y, 30-3-0.5, false);
event_inherited();