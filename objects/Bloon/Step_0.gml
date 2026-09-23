/// @description Insert description here
// You can write your code in this editor
if (sprite_index == -1)
{
	var sprind = calculatespriteindex(typeIndex, Atrs);
	var spr = BloonRenderer.BloonSprites[? sprind];
	if (is_undefined(spr))
	{
		
	}
	else sprite_index = spr;
}
if (sprite_get_number(sprite_index) >= 5)
{
	var hpstate = clamp(5 - ceil(5 * hp / MaxHp), 0, 4);
	image_index = hpstate;
}
