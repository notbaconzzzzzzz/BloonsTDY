/// @description Insert description here
// You can write your code in this editor
calculaterange();
calculateattackspeed();
attackDelay = 0;

Upgrades = upg.none;
TotalT12 = 0;
TotalT3 = 0;
TotalT4 = 0;
LowestT12 = 999999;
HighestT12 = 0;
LowestT3 = 999999;
SumT4 = 0;
NextRandUp = irandom_range(1, 4);
PossibleUpgrades = [];
for (var i = 0; i <= 20; i++)
{
	PossibleUpgrades[i] = isupgradepossible(getindexupgpath(i), getindexupgtier(i));
}

UpgradeColors = [];
UpgradeAlphas = [];
for (var j = 1; j <= 4; j++)
{
	for (var i = 1; i <= 6; i++)
	{
		for (var k = -2; k <= 2; k++)
		{
			var colorr = 255;
			var colorg = 255;
			var colorb = 255;
			switch (i)
			{
				case 1: {colorr = 244; colorg = 204; colorb = 204;} break;
				case 2: {colorr = 201; colorg = 218; colorb = 248;} break;
				case 3: {colorr = 252; colorg = 229; colorb = 205;} break;
				case 4: {colorr = 217; colorg = 234; colorb = 211;} break;
				case 5: {colorr = 217; colorg = 210; colorb = 233;} break;
				case 6: {colorr = 255; colorg = 242; colorb = 204;} break;
			}
			colorr = colorr * (1 + j / 2) - 255 * (1 + j / 2 - 1);
			colorg = colorg * (1 + j / 2) - 255 * (1 + j / 2 - 1);
			colorb = colorb * (1 + j / 2) - 255 * (1 + j / 2 - 1);
			var colora = 15;
			switch (k)
			{
				case -2: colora = 15; break;
				case -1: colora = 63; colorr = 255 / 4 + colorr / 2; colorg = 255 / 4 + colorg / 2; colorb = 255 / 4 + colorb / 2; break;
				case 0: colora = 127; colorr = colorr * 3 / 4; colorg = colorg * 3 / 4; colorb = colorb * 3 / 4; break;
				case 1: colora = 127; colorr = 255 / 4 + colorr * 3 / 4; colorg = 255 / 4 + colorg * 3 / 4; colorb = 255 / 4 + colorb * 3 / 4; break;
				case 2: colora = 255; break;
			}
			UpgradeColors[j*30 + i*5 + k - 33] = make_color_rgb(colorr, colorg, colorb);
			UpgradeAlphas[j*30 + i*5 + k - 33] = colora / 255;
		}
	}
}