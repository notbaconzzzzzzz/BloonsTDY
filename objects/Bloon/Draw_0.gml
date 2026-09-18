if (blimp)
{
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, -round(dir / 15) * 15, c_white, 1);
}
else
{
	draw_self();
}