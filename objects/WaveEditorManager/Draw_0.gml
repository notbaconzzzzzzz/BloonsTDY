var waveScaleY = 60;
var timeScaleX = 1;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
for (var i = floor(verticalScroll); i < array_length(WaveData) && i < verticalScroll + 1080 / waveScaleY; i++)
{
	var wave = WaveData[i];
	var drawY = i * waveScaleY - verticalScroll * waveScaleY + waveScaleY / 2;
	var drawX = 0;
	for (var j = 0; j < array_length(wave); j++)
	{
		var group = wave[j];
		var sprind = calculatespriteindex(group.typeIndex, group.bloonData.atrs | group.mods);
		var bloonSprite = BloonRenderer.BloonSprites[? sprind];
		if (is_undefined(bloonSprite))
		{
			if (!array_contains(BloonRenderer.drawQueue, sprind)) array_push(BloonRenderer.drawQueue, sprind);
			break;
		}
		drawX = group._resolvedTime * waveScaleY + 120;
		if ((group.spacing <= 6 && group.amt != 1) || group.amt >= 30)
		{
			draw_set_alpha(0.2);
			var col = make_color_hsv(group.bloonData.colors[0].h/360*255, group.bloonData.colors[0].s, group.bloonData.colors[0].v);
			draw_set_color(col);
			draw_rectangle(drawX, drawY - group.bloonData.size / 16, drawX + wavegrouplength(group, false) * timeScaleX, drawY + group.bloonData.size / 16, false);
			draw_set_alpha(1);
			draw_sprite(bloonSprite, 0, drawX, drawY);
			draw_set_color(c_black);
			if (group.bloonData.type == "black") draw_set_color(c_white);
			draw_text(drawX, drawY, "x" + string(group.amt));
		}
		else
		{
			draw_set_alpha(0.2);
			for (var k = group.amt - 1; k > 0; k--)
			{
				draw_sprite(bloonSprite, 0, drawX + k * group.spacing * timeScaleX, drawY);
			}
			draw_set_alpha(1);
			draw_sprite(bloonSprite, 0, drawX, drawY);
		}
		if (waveSelectionInd == i && groupSelectionInd == j)
		{
			draw_set_alpha(0.1);
			draw_set_color(c_white);
			draw_circle(drawX, drawY, 60, false);
			draw_set_alpha(1);
		}
	}
	if (waveSelectionInd == i)
	{
		draw_set_alpha(0.5);
		draw_set_color(c_black);
		draw_rectangle(10, drawY - waveScaleY / 2, 20, drawY + waveScaleY / 2, false);
		draw_set_alpha(1);
	}
}