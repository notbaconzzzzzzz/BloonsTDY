var waveScaleY = 120;
var timeScaleX = 1;
for (var i = max(floor(verticalScroll), 0); i < min(array_length(WaveData), verticalScroll + 1080 / waveScaleY); i++)
{
	var wave = WaveData[i];
	var info = WaveInfo[i];
	var drawY = i * waveScaleY - verticalScroll * waveScaleY + waveScaleY / 2;
	var drawX = 0;
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	for (var j = 0; j < array_length(wave); j++)
	{
		var group = wave[j];
		var bloonSprite = group._bloonSprite;
		if (bloonSprite == -1)
		{
			bloonSprite = BloonRenderer.BloonSprites[? group._sprind];
			if (is_undefined(bloonSprite))
			{
				break;
			}
			group._bloonSprite = bloonSprite
		}
		drawX = group._resolvedTime * timeScaleX + 120;
		var bloonDrawScale = 1;
		if (group.bloonData.size > 60) bloonDrawScale = 120 / (group.bloonData.size + 60);
		var amtAlpha = 0.25;
		if ((group.spacing <= group.bloonData.size / 8 * bloonDrawScale && group.amt > 1) || group.amt >= 30)
		{
			draw_set_alpha(0.2);
			var col = make_color_hsv(group.bloonData.colors[0].h/360*255, group.bloonData.colors[0].s, group.bloonData.colors[0].v);
			draw_set_color(col);
			draw_rectangle(drawX, drawY - group.bloonData.size / 16 * bloonDrawScale, drawX + wavegrouplength(group, false) * timeScaleX, drawY + group.bloonData.size / 16, false);
			draw_set_alpha(1);
			draw_sprite_ext(bloonSprite, 0, drawX, drawY, bloonDrawScale, bloonDrawScale, 0, c_white, 1);
			amtAlpha = 1;
		}
		else
		{
			for (var k = group.amt - 1; k > 0; k--)
			{
				draw_sprite_ext(bloonSprite, 0, drawX + k * group.spacing * timeScaleX, drawY, bloonDrawScale, bloonDrawScale, 0, c_white, 0.2);
			}
			draw_sprite_ext(bloonSprite, 0, drawX, drawY, bloonDrawScale, bloonDrawScale, 0, c_white, 1);
		}
		draw_set_color(c_black);
		if (group.bloonData.type == "black") draw_set_color(c_white);
		if (waveSelectionInd == i && groupSelectionInd == j)
		{
			draw_set_alpha(0.1);
			draw_set_color(c_white);
			draw_circle(drawX, drawY, 60, false);
			draw_set_color(c_black);
			draw_set_alpha(1);
			draw_text(drawX, drawY + 50, "/" + string(group.spacing) + "f");
			draw_set_alpha(1);
			draw_text(drawX, drawY - 50, "at " + string(group.offset) + (group.offsetreference != -1 ? " from " + string(group.offsetreference) : ""));
			amtAlpha = 1;
		}
		if (group.bloonData.type == "black" || group.bloonData.type == "indigo") draw_set_color(c_white);
		draw_set_alpha(amtAlpha);
		draw_text(drawX, drawY, "x" + string(group.amt));
		draw_set_alpha(1);
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_black);
	draw_text(30, drawY - 40, "Round " + string(i));
	draw_text(30, drawY - 0, "$" + string(info.money));
	draw_text(30, drawY + 20, string_format(info.length / 60, 0, 2) + "s");
	if (waveSelectionInd == i)
	{
		draw_set_alpha(0.5);
		draw_set_color(c_black);
		draw_rectangle(10, drawY - waveScaleY / 2, 20, drawY + waveScaleY / 2, false);
		draw_set_alpha(1);
	}
}