/// @description Insert description here
// You can write your code in this editor
if (PlayerModel.showUpgradeIndicators)
{
	for (var j = 1; j <= 4; j++)
	{
		for (var i = 1; i <= (j <= 2 ? 4 : 6); i++)
		{
			var drawx = x;
			var drawy = y;
			var draww = 4;
			var drawh = 8;
			var dx = 5;
			var dy = 10;
			dx *= j - 1/2;
			if (j < 3) dy /= 2;
			switch (i)
			{
				case 1: drawx -= dx; drawy -= dy; break;
				case 2: drawx -= dx; drawy += dy; break;
				case 3: drawx += dx; drawy -= dy; break;
				case 4: drawx += dx; drawy += dy; break;
				case 5: drawx -= dx; break;
				case 6: drawx += dx; break;
			}
			var k = PossibleUpgrades[getupgindex(i, j)];
			switch (k)
			{
				case -2: draww *= 1; drawh *= 1/4; break;
				case -1: draww *= 1; drawh *= 1/4; break;
				case 0: draww *= 1; drawh *= 1/2; break;
				case 1: draww *= 1; drawh *= 3/4; break;
				case 2: draww *= 1; drawh *= 1; break;
			}
			var colIndex = j*30 + i*5 + k - 33;
			draw_set_color(UpgradeColors[colIndex]);
			draw_set_alpha(UpgradeAlphas[colIndex]);
			draw_rectangle(drawx - draww/2, drawy - drawh/2, drawx + draww/2 - 1, drawy + drawh/2 - 1, false);
		}
	}
}
if (PlayerModel.quickUpgradeTower == id && !PlayerModel.tryingtobuytower)
{
	draw_set_color(c_white);
	draw_set_alpha(0.5);
	draw_circle(x, y, 100, false);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var path5 = isupgradevalid(5) == 1;
	var path6 = isupgradevalid(6) == 1;
	for (var i = 1; i <= 6; i++)
	{
		if (i == 5 && !path5) continue;
		if (i == 6 && !path6) continue;
		var triple = false;
		if (path5 && (i == 1 || i == 2 || i == 5)) triple = true;
		if (path6 && (i == 3 || i == 4 || i == 6)) triple = true;
		var drawx = x;
		var drawy = y;
		var draww = 100;
		var drawh = 100;
		if (triple) drawh = 200/3;
		switch (i)
		{
			case 1: drawx += -50; drawy += triple ? -200/3 : -50; break;
			case 2: drawx += -50; drawy += triple ? 200/3 : 50; break;
			case 3: drawx += 50; drawy += triple ? -200/3 : -50; break;
			case 4: drawx += 50; drawy += triple ? 200/3 : 50; break;
			case 5: drawx += -50; drawy += 0; break;
			case 6: drawx += 50; drawy += 0; break;
		}
		if (PlayerModel.hoverQuadrant == i)
		{
			draw_set_color(c_white);
			draw_set_alpha(0.5);
			draw_rectangle(drawx-draww/2, drawy-drawh/2, drawx+draww/2, drawy+drawh/2, false);
		}
		else if (PlayerModel.autobuyupgrade && NextRandUp == i)
		{
			draw_set_color(c_purple);
			draw_set_alpha(0.2);
			draw_rectangle(drawx-draww/2, drawy-drawh/2, drawx+draww/2, drawy+drawh/2, false);
		}
		if (isupgradevalid(i) != 1) continue;
		var p = getupgradeprice(i);
		if (p == -1) continue;
		if (p.price <= PlayerModel.money)
		{
			draw_set_color(c_black);
			draw_set_alpha(1);
		}
		else
		{
			draw_set_color(c_maroon);
			draw_set_alpha(0.8);
		}
		draw_text_transformed(drawx, drawy - 10, string(p.up.name), 2/3, 2/3, 0);
		draw_text(drawx, drawy + 10, "$" + string(p.price));
		if (PlayerModel.hoverQuadrant == i)
		{
			var desc = string(p.up.desc);
			var wide = string_width(desc);
			var high = string_height(desc);
			var alignx = 0.5;
			var aligny = 1;
			drawx = x;
			drawy = y - 120;
			draw_set_halign(fa_center);
			draw_set_valign(fa_bottom);
			if (drawy - high < 10)
			{
				draw_set_valign(fa_top);
				aligny = 0;
				drawy = y + 120;
			}
			if (drawx - wide / 2 < GameManager.shmupLeftBound + 10)
			{
				draw_set_halign(fa_left);
				alignx = 0;
			}
			else if (drawx + wide / 2 > GameManager.shmupRightBound - 10)
			{
				draw_set_halign(fa_right);
				alignx = 1;
			}
			draw_set_color(c_white);
			draw_set_alpha(0.5);
			draw_rectangle(drawx - wide * alignx - 10, drawy - high * aligny - 10, drawx + wide - wide * alignx + 10, drawy + high - high * aligny + 10, false);
			draw_set_color(c_black);
			draw_set_alpha(1);
			draw_text_transformed(drawx, drawy, desc, 1, 1, 0);
			draw_set_valign(fa_middle);
			draw_set_halign(fa_center);
		}
	}
}
draw_set_alpha(1);