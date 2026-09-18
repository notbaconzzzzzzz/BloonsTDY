// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function resetround()
{
	randomize();
	currentRound = StartRound;
	BloonIncomeFactor = 100;
	RoundIncomeFactor = 100;
	FarmIncomeFactor = 100;
	wait = 0;
	dif = 1;
	pdif = 0;
	pbudget = 0;
	pbudgets = [];
	maxbudget = 2000;
	rate = 100;
	maxblns = 10;
	delay = 30;
	hasSeen = array_create(array_length(DataManager.BloonData), false);
	shmupLeftBound = 0;
	shmupRightBound = room_width - 8 * 60;
	with (PlayerModel)
	{
		money = GameManager.StartingMoney;
		bloonFrac = 5000;
		lifes = GameManager.StartingLifes;
		livesFrac = 5000;
		numberoftowers = 0;
		hoveredTower = noone;
		hoverQuadrant = 0;
	}
	startround();
}

function startround()
{
	budget = maxbudget;
	blns = maxblns;
}

function endround()
{
	PlayerModel.money += round((100 + currentRound) * RoundIncomeFactor * AllIncomeFactor / 100 / 100);
	currentRound += 1;
	pdif = dif;
	pbudget = budget;
	array_push(pbudgets, pbudget);
	if (currentRound <= 6) dif += 0.5; // 1 ~ 3.5
	else if (currentRound <= 9) dif += 1; // 4.5 ~ 7.5
	else if (currentRound <= 14) dif += 1.5; // 9 ~ 15
	else if (currentRound <= 21) dif += 3; // 18 ~ 36
	else if (currentRound <= 30) dif += 4; // 40 ~ 72
	else if (currentRound <= 34) dif += 6; // 78 ~ 96
	else if (currentRound <= 37) dif += 12; // 108 ~ 132
	else if (currentRound <= 39) dif += 20; // 152 ~ 172
	else if (currentRound <= 40) dif += 128; // 300
	else dif += 2 * sqrt(dif / 3);
	/*
	if (currentRound < 10)
	{
		if (currentRound % 2 == 1)
		{
			shmupLeftBound -= 30;
			shmupRightBound += 30;
		}
	}
	else if (currentRound < 25)
	{
		shmupLeftBound -= 30;
		shmupRightBound += 30;
	}
	else
	{
		shmupLeftBound = 0;
		shmupRightBound = room_width - 8 * 60;
	}*/
	if (currentRound == 51)      { BloonIncomeFactor = 80; RoundIncomeFactor = 120; }
	else if (currentRound == 61) { BloonIncomeFactor = 50; RoundIncomeFactor = 150; }
	else if (currentRound == 86) { BloonIncomeFactor = 34; RoundIncomeFactor = 200; }
	else if (currentRound == 101) { BloonIncomeFactor = 20; RoundIncomeFactor = 300; }
	else if (currentRound == 121) { BloonIncomeFactor = 10; RoundIncomeFactor = 500; }
	//AllIncomeFactor += 5;
	rate = ceil(100 / (1 + 2 * log10(currentRound)));
	maxblns = floor(min(10 + sqrt(currentRound), 20) * (1 + 2 * log10(currentRound)));
	maxbudget = 10 * (1 + 2 * log10(currentRound)) * dif * 200;
	startround();
}

function spawnrandombloon()
{
	var type = "red";
	var o = 0;
	var rand = 0;
	for (var i = 0; i < 45; i++)
	{
		rand += getbloonweight(DataManager.BloonData[i]);
	}
	rand = random_range(0, rand);
	for (var i = 0; i < 45; i++)
	{
		rand -= getbloonweight(DataManager.BloonData[i]);
		if (rand <= 0)
		{
			o = i;
			break;
		}
	}
	//o = floor(sqrt(random_range(sqrt(dif) / 2, dif) * random_range(sqrt(dif) / 2, dif)));
	//if (o >= 38) o = 37;
	var bloonData = DataManager.BloonData[o];
	type = DataManager.BloonOrd[o];
	var mods = atr.none;
	if (random(1) < clamp((currentRound / ((bloonData.spd >= 200 || bloonData.type == "bbt") ? 1.5 : 1) - 40) / 60 * 0.5, 0, 0.5)) mods |= atr.stream;
	if (!has(bloonData.atrs, atr.moab) || hasany(bloonData.atrs, atr.bob | atr.honey))
	{
		if (random(1) < clamp((currentRound / (hasany(bloonData.atrs, atr.canthits) ? 1.5 : 1) - 10) / 70 * 0.5, 0, 0.5)) mods |= atr.camo;
		if (random(1) < clamp((currentRound / (bloonData.dmg > 40 ? 2 : 1) - 0) / 30 * 0.5, 0, 0.5)) mods |= atr.regrow;
		if (random(1) < clamp((currentRound / (bloonData.hp > 1 ? 1.5 : 1) - 20) / 40 * 0.5, 0, 0.5)) mods |= atr.latex;
	}
	if (hasany(bloonData.atrs, atr.canfort))
	{
		if (random(1) < clamp((currentRound / (has(bloonData.atrs, atr.moab) ? 2 : 1) - 30) / 40 * 0.5, 0, 0.5)) mods |= atr.fort;
	}
	spawnbloon(type, mods);
	return bloonData;
}

function spawnbloon(type, mods = -1, removemods = -1)
{
	var typeInd = -1;
	if (is_numeric(type))
	{
		typeInd = type;
		type = DataManager.BloonOrd[type];
	}
	else
	{
		typeInd = array_get_index(DataManager.BloonOrd, type);
	}
	if (!GameManager.hasSeen[typeInd])
	{
		GameManager.hasSeen[typeInd] = true;
		if (is_struct(DataManager.BloonData[typeInd].moab) && DataManager.BloonData[typeInd].moab.class > 0)
		{
			audio_play_sound(MoabWarHorn, 800, false, 4);
		}
	}
	var strut = {type : type, dir : random_range(45, 135)};
	if (mods != -1) strut.Atrs = mods;
	if (removemods != -1) strut.RemoveAtrs = removemods;
	//instance_create_layer(random_range(shmupLeftBound, shmupRightBound), -64, "Bloons", ShmupBloon, strut);
	instance_create_layer(-999, -999, "Bloons", TrackBloon, strut);
}

function getbloonweight(bloon, difficulty = -1, remainingbudget = -1, remainingbloons = -1, scale = true)
{
	if (!GameManager.HoneyBloons && bloon.ind >= 40 && bloon.ind <= 44) return 0;
	if (difficulty == -1) difficulty = dif;
	if (scale && remainingbudget == -1) remainingbudget = budget;
	if (scale && remainingbloons == -1) remainingbloons = blns;
	var d = bloon.dif;
	var d2 = d;
	var size = 1;
	var w = 1;
	if (is_struct(bloon.moab))
	{
		size = 2 * power(2, bloon.moab.class);
		switch (bloon.moab.class)
		{
			case 0: d /= 2; break;
			case 1: d /= 4; break;
			case 2: d /= 6; break;
			case 3: d /= 8; break;
			case 4: d /= 10; break;
		}
		if (scale)
		{
			w /= 2 * power(2, bloon.moab.class);
		}
	}
	if (d < sqrt(difficulty) * 50) w = 0;
	else if (d <= difficulty * 200) w *= sqrt(d / difficulty / 200);
	else if (d <= difficulty * 400) w *= sqr(200 * difficulty / d);
	else w = 0;
	if (scale)
	{
		var expected = getbloonaveragedif(difficulty);
		if (remainingbloons < size) w = 0;
		else if (remainingbloons == size ? (remainingbudget * 2 < d2) : (remainingbudget < d2)) w = 0;
		else
		{
			var idealdif = remainingbudget * size / remainingbloons;
			if (d2 < idealdif)
			{
				w *= power(4, (1 - idealdif / d2) * size / remainingbloons);
			}
			else
			{
				w *= (1 - ((d2 / idealdif - 1) * size / remainingbloons));
			}
			w *= power(idealdif / expected, logn(exp(1), d2 / expected));
		}
		if (remainingbloons == size) w *= size;
	}
	return w;
}

function getbloonaveragedif(difficulty = -1)
{
	if (difficulty == -1) difficulty = dif;
	var total = 0;
	var width = 0;
	for (var i = 0; i < 45; i++)
	{
		var bloon = DataManager.BloonData[i];
		if (!GameManager.HoneyBloons && bloon.ind >= 40 && bloon.ind <= 44) continue;
		var d = bloon.dif;
		var d2 = d;
		var size = 1;
		var w = 1;
		if (is_struct(bloon.moab))
		{
			size = 2 * power(2, bloon.moab.class);
			switch (bloon.moab.class)
			{
				case 0: d /= 2; break;
				case 1: d /= 4; break;
				case 2: d /= 6; break;
				case 3: d /= 8; break;
				case 4: d /= 10; break;
			}
			if (true)
			{
				w /= 2 * power(2, bloon.moab.class);
			}
		}
		if (d < sqrt(difficulty) * 50) w = 0;
		else if (d <= difficulty * 200) w *= sqrt(d / difficulty / 200);
		else if (d <= difficulty * 400) w *= sqr(200 * difficulty / d);
		else w = 0;
		total += d2 * w;
		width += w;
	}
	return total / width;
}