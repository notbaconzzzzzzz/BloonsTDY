/// @description Insert description here
// You can write your code in this editor
draw_set_halign(fa_left);
draw_set_valign(fa_top);
/*
if (debug)
{
	for (var i = 0; i < array_length(BloonData); i++)
	{
		var bloon = BloonData[i];
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_text(20, i*24, bloon.type);
		draw_text(100, i*24, bloon.spd);
		draw_text(130, i*24, bloon.hp);
		draw_text(180, i*24, stringify(bloon.dif / 200));
		//draw_text(180, i*24, bloon.spawns);
		//draw_text(180, i*24, bloon.moab);
		//if (i >= 38) continue;
	
		draw_set_alpha(0.2);
		var w = getbloonweight(BloonData[i], dif, -1, -1, false);
		if (w > 0)
		{
			draw_set_color(c_purple);
			draw_rectangle(0, i*24, 0 + 240 * w - 1, i*24 + 24 - 1, false);
		}
	
		w = getbloonweight(BloonData[i], dif, -1, -1, true);
		if (w > 0)
		{
			draw_set_alpha(0.5);
			draw_set_color(c_navy);
			draw_rectangle(0 + 240 * w - 2, i*24 + 1, 0 + 240 * w - 1, i*24 + 3 - 1, false);
			draw_rectangle(0 + 240 * w - 2, i*24 + 5, 0 + 240 * w - 1, i*24 + 7 - 1, false);
			draw_rectangle(0 + 240 * w - 2, i*24 + 9, 0 + 240 * w - 1, i*24 + 11 - 1, false);
			draw_rectangle(0 + 240 * w - 2, i*24 + 13, 0 + 240 * w - 1, i*24 + 15 - 1, false);
			draw_rectangle(0 + 240 * w - 2, i*24 + 17, 0 + 240 * w - 1, i*24 + 19 - 1, false);
			draw_rectangle(0 + 240 * w - 2, i*24 + 21, 0 + 240 * w - 1, i*24 + 23 - 1, false);
		}
	}
}*/

draw_set_color(c_white);
if (debug)
{
	for (var i = 0; i < blnsnd.TOTAL_COUNT; i++)
	{
		draw_text(1500, 40 + 20 * i, bloonSounds[i]);
		for (var j = 0; j < array_length(bloonSoundVariations[i]); j++)
		{
			draw_text(1600 + j * 20, 40 + 20 * i, bloonSoundVariations[i][j]);
		}
	}
}

draw_set_alpha(0.5);
draw_set_color(c_teal);
draw_rectangle(40, 100, (40) + 200 * (blns / maxblns) - 1, 120, false);
draw_set_color(c_orange);
draw_rectangle(40, 120, (40) + 200 * (budget / maxbudget) - 1, 140, false);
draw_set_alpha(1);
draw_set_color(c_black);
draw_text(40, 80, "Round: " + string(currentRound));
draw_text(140, 80, "(Dif " + stringify(dif) + ")");
draw_text(40, 100, "bloons");
draw_set_halign(fa_right);
draw_text(150, 100, string(blns));
draw_set_halign(fa_middle);
draw_text(160, 100, "/");
draw_set_halign(fa_left);
draw_text(170, 100, string(maxblns));
draw_text(40, 120, "budget");
draw_set_halign(fa_right);
draw_text(150, 120, stringify(budget / 200));
draw_set_halign(fa_middle);
draw_text(160, 120, "/");
draw_set_halign(fa_left);
draw_text(170, 120, stringify(maxbudget / 200));
var avoffby = 0;
for (var i = 0; i < array_length(pbudgets); i++)
{
	avoffby += pbudgets[i];
}
if (array_length(pbudgets) > 0) avoffby /= array_length(pbudgets);
draw_text(240, 120, "Off by " + (pbudget < 0 ? "-" : "+") + stringify(abs(pbudget) / 200) + " (" + (avoffby < 0 ? "-" : "+") + stringify(abs(avoffby) / 200) + ")");

if (shmupLeftBound > 0)
{
	draw_set_color(c_black);
	draw_set_alpha(0.2);
	draw_rectangle(0, 0, shmupLeftBound, room_height, false);
}
if (shmupRightBound < room_width)
{
	draw_set_color(c_black);
	draw_set_alpha(0.2);
	draw_rectangle(shmupRightBound, 0, room_width, room_height, false);
}