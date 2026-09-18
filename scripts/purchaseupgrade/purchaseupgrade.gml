// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function isupgradevalid(path, tier = -1)
{
	if (path < 1 || path > 6) return -2;
	if (tier == -1)
	{
		for (tier = path >= 5 ? 3 : 1; tier <= 4; tier++)
		{
			if (!has(Upgrades, getupgfromindex(path, tier))) break;
		}
		if (tier > 4) return -2;
	}
	else if (has(Upgrades, getupgfromindex(path, tier))) return -2;
	if (path >= 5 && tier < 3) return -2;
	if (tier - (path >= 5 ? 2 : 0) > array_length(TowerData.ups[path-1])) return -2;
	if (!has(Upgrades, getupgprereq(path, tier))) return -1;
	if (hasany(Upgrades, getupgnoreq(path, tier))) return -1;
	if ((tier == 1 || tier == 2) && TotalT12 >= 6) return 0;
	if (tier == 3 && TotalT3 >= 2) return 0;
	if (tier == 4 && TotalT4 >= 1) return 0;
	return 1;
}

function isupgradepossible(path, tier = -1)
{
	if (path == 0 && tier == 0) return 2;
	if (path < 1 || path > 6) return -2;
	if (tier == -1)
	{
		for (tier = path >= 5 ? 3 : 1; tier <= 4; tier++)
		{
			if (!has(Upgrades, getupgfromindex(path, tier))) break;
		}
		if (tier > 4) return -2;
	}
	else if (has(Upgrades, getupgfromindex(path, tier))) return 2;
	if (path >= 5 && tier < 3) return -2;
	if (tier - (path >= 5 ? 2 : 0) > array_length(TowerData.ups[path-1])) return -2;
	
	if (hasany(Upgrades, getupgnoreq(path, tier))) return -1;
	if ((tier == 1 || tier == 2) && TotalT12 >= 6) return -1;
	if (tier == 3 && TotalT3 >= 2) return -1;
	if (tier == 4 && TotalT4 >= 1) return -1;
	
	if (!has(Upgrades, getupgprereq(path, tier)))
	{
		var tT12 = TotalT12;
		var tT3 = TotalT3;
		var tT4 = TotalT4
		for (var t = tier; t >= 1; t--)
		{
			if (path >= 5 && t <= 2)
			{
				var p1 = path == 5 ? 1 : 3;
				var p2 = path == 5 ? 2 : 4;
				if (!has(Upgrades, getupgfromindex(p1, t)))
				{
					tT12++;
				}
				if (!has(Upgrades, getupgfromindex(p2, t)))
				{
					tT12++;
				}
			}
			else
			{
				if (!has(Upgrades, getupgfromindex(path, t)))
				{
					switch (t) { case 1: case 2: tT12++; break; case 3: tT3++; break; case 4: tT4++; break; }
				}
			}
		}
		if (tT12 > 6) return -1;
		if (tT3 > 2) return -1;
		if (tT4 > 1) return -1;
		return 0;
	}
	return 1;
}

function getupgprereq(path, tier)
{
	switch (tier)
	{
		case 1: return upg.none;
		case 2: switch (path) {
				case 1: return upg.a1;
				case 2: return upg.b1;
				case 3: return upg.c1;
				case 4: return upg.d1; } return upg.none;
		case 3: switch (path) {
				case 1: return upg.a2;
				case 2: return upg.b2;
				case 3: return upg.c2;
				case 4: return upg.d2;
				case 5: return upg.a2 | upg.b2;
				case 6: return upg.c2 | upg.d2; } return upg.none;
		case 4: switch (path) {
				case 1: return upg.a3;
				case 2: return upg.b3;
				case 3: return upg.c3;
				case 4: return upg.d3;
				case 5: return upg.e3;
				case 6: return upg.f3; } return upg.none;
	}
	return upg.none;
}

function getupgnoreq(path, tier)
{
	if (tier >= 3) switch (path) {
		case 1: return upg.c3;
		case 2: return upg.d3;
		case 3: return upg.a3;
		case 4: return upg.b3;
		case 5: return upg.f3;
		case 6: return upg.e3;
	}
	return upg.none;
}

function getupgindex(path, tier)
{
	switch (tier)
	{
		case 0: if (path == 0) return 0; return -1;
		case 1: switch (path) {
				case 1: return 1;
				case 2: return 2;
				case 3: return 3;
				case 4: return 4; } return -1;
		case 2: switch (path) {
				case 1: return 5;
				case 2: return 6;
				case 3: return 7;
				case 4: return 8; } return -1;
		case 3: switch (path) {
				case 1: return 9;
				case 2: return 10;
				case 3: return 11;
				case 4: return 12;
				case 5: return 13;
				case 6: return 14; } return -1;
		case 4: switch (path) {
				case 1: return 15;
				case 2: return 16;
				case 3: return 17;
				case 4: return 18;
				case 5: return 19;
				case 6: return 20; } return -1;
	}
	return -1;
}

function getindexupgpath(index)
{
	switch (index)
	{
		case 0:
			return 0;
		case 1:
		case 5:
		case 9:
		case 15:
			return 1;
		case 2:
		case 6:
		case 10:
		case 16:
			return 2;
		case 3:
		case 7:
		case 11:
		case 17:
			return 3;
		case 4:
		case 8:
		case 12:
		case 18:
			return 4;
		case 13:
		case 19:
			return 5;
		case 14:
		case 20:
			return 6;
	}
	return 0;
}

function getindexupgtier(index)
{
	if (index == 0) return 0;
	if (index <= 4) return 1;
	if (index <= 8) return 2;
	if (index <= 14) return 3;
	if (index <= 20) return 4;
	return -1;
}

function purchasetower(tx, ty, type = "Dart Monkey")
{
	if (tx == -999)
	{
		var pos = getrandomtowerposition();
		if (pos.tx == -999) return -1;
		tx = pos.tx;
		ty = pos.ty;
	}
	if (PlayerModel.money < 200) return 0;
	if (placetower(tx, ty, type) > 0)
	{
		money -= 200;
		audio_play_sound(random(1) < 0.5 ? PlaceTowerMonkey01 : PlaceTowerMonkey02, 500, false);
		return 1;
	}
	return -1;
}

function placetower(tx, ty, type)
{
	if (tx == -999)
	{
		var pos = getrandomtowerposition();
		if (pos.tx == -999) return -1;
		tx = pos.tx;
		ty = pos.ty;
	}
	if (!isvalidtowerposition(tx, ty, type))
	{
		return -1;
	}
	instance_create_layer(tx, ty, "Towers", DartMonkey);
	PlayerModel.numberoftowers++;
	return 1;
}

function isvalidtowerposition(tx, ty, type = "Dart Monkey")
{
	var dist = 0;
	dist = min(tx - GameManager.shmupLeftBound, GameManager.shmupRightBound - tx);
	if (dist < 60) return false;
	dist = min(ty - 0, room_height - ty);
	if (dist < 60) return false;
	with (Tower)
	{
		dist = sqrt(sqr(x - tx) + sqr(y - ty));
		if (dist < 60) return false;
	}
	return true;
}

function getrandomtowerposition()
{
	var tx = 0;
	var ty = 0;
	var dist = 0;
	var bestx = -999;
	var besty = -999;
	var bestdist = 60;
	var d = 0;
	for (var i = 0; i < 100; i++)
	{
		path = juncchoosepath(TrackManager.StartingJunc);
		patht = 0;
		pathmovement(random_range(180, path.finishdist - 180));
		var offset = (irandom(1)*2-1) * random_range(60, 180);
		tx = x - offset * dsin(dir);
		ty = y + offset * dcos(dir);
		/*
		tx = random_range(GameManager.shmupLeftBound, GameManager.shmupRightBound);
		ty = random_range(room_height * 0.3333, room_height * 0.8333);*/
		tx = round(tx / grid) * grid;
		ty = round(ty / grid) * grid;
		if (!isvalidtowerposition(tx, ty)) continue;
		dist = min(tx - GameManager.shmupLeftBound / 2, (GameManager.shmupRightBound + room_width) / 2 - tx) * 2;
		with (Tower)
		{
			d = sqrt(sqr(x - tx) + sqr(y - ty));
			if (d < dist) dist = d;
		}
		if (dist >= bestdist)
		{
			bestx = tx;
			besty = ty;
			bestdist = dist;
		}
	}
	return {tx : bestx, ty : besty};
}

function purchaseupgrade(path, tier = -1)
{
	if (path < 1 || path > 6) return -1;
	if (tier == -1)
	{
		for (tier = 1; tier <= 4; tier++)
		{
			if (!has(Upgrades, getupgfromindex(path, tier))) break;
		}
		if (tier > 4) return -1;
	}
	if (isupgradevalid(path, tier) != 1) return -1;
	var p = getupgradeprice(path, tier);
	if (p == -1) return -1;
	if (PlayerModel.money < p.price) return 0;
	PlayerModel.money -= p.price;
	Upgrades |= getupgfromindex(path, tier);
	if (variable_struct_exists(p.up, "action")) p.up.action(id);
	audio_play_sound(TowerUpgrade, 500, false);
	if (tier == 1 || tier == 2)
	{
		TotalT12++;
		if (p.oprice < LowestT12) LowestT12 = p.oprice;
		if (p.oprice > HighestT12) HighestT12 = p.oprice;
	}
	else if (tier == 3)
	{
		TotalT3++;
		if (p.oprice < LowestT3) LowestT3 = p.oprice;
	}
	else if (tier == 4)
	{
		TotalT4++;
		SumT4 += p.oprice;
	}
	for (var i = 0; i <= 20; i++)
	{
		PossibleUpgrades[i] = isupgradepossible(getindexupgpath(i), getindexupgtier(i));
	}
	return 1;
}

function getupgradeprice(path, tier = -1)
{
	if (path == 0 && tier == 0)
	{
		return { up : -1, price : 200, oprice : 200 };
	}
	if (path < 1 || path > 6) return -1;
	if (tier == -1)
	{
		for (tier = 1; tier <= 4; tier++)
		{
			if (!has(Upgrades, getupgfromindex(path, tier))) break;
		}
		if (tier > 4) return -1;
	}
	if (path >= 5) tier -= 2;
	if (tier <= 0 || tier > array_length(TowerData.ups[path-1])) return -1;
	var up = TowerData.ups[path-1][tier-1];
	if (path >= 5) tier += 2;
	var price = up.price;
	if (tier == 1 || tier == 2)
	{
		var newTotalT12 = TotalT12 + 1;
		var newLowestT12 = LowestT12;
		var newHighestT12 = HighestT12;
		if (price < newLowestT12) newLowestT12 = price;
		if (price > newHighestT12) newHighestT12 = price;
		if (newTotalT12 == 5)
		{
			price += newLowestT12;
		}
		else if (newTotalT12 > 5 && newLowestT12 != LowestT12)
		{
			price += newLowestT12 - LowestT12;
		}
		if (newTotalT12 == 6)
		{
			price += newHighestT12;
		}
		else if (newTotalT12 > 6 && newHighestT12 != HighestT12)
		{
			price += newHighestT12 - HighestT12;
		}
	}
	else if (tier == 3)
	{
		var newTotalT3 = TotalT3 + 1;
		var newLowestT3 = LowestT3;
		if (price < newLowestT3) newLowestT3 = price;
		if (newTotalT3 == 2)
		{
			price += round(newLowestT3 * 3 / 5 / 5) * 5;
		}
		else if (newTotalT3 > 2 && newLowestT3 != LowestT3)
		{
			price += round(newLowestT3 * 3 / 5 / 5) * 5 - round(LowestT3 * 3 / 5 / 5) * 5;
		}
		if (newTotalT3 == 2)
		{
			price += round(SumT4 * 1 / 5 / 5) * 5;
		}
	}
	else if (tier == 4)
	{
		var newTotalT4 = TotalT4 + 1;
		var newSumT4 = SumT4;
		newSumT4 += price;
		if (TotalT3 >= 2)
		{
			price += round(newSumT4 * 1 / 5 / 5) * 5 - round(SumT4 * 1 / 5 / 5) * 5;
		}
	}
	return { up : up, price : price, oprice : up.price };
}