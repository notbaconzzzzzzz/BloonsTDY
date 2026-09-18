draw_set_color(c_white);
draw_set_alpha(0.5);
draw_line_width(x - 50, y, x + 50, y, 4);
draw_set_alpha(1);
draw_circle(x - 50 + value * 100, y, 10, false);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y - 20, label);