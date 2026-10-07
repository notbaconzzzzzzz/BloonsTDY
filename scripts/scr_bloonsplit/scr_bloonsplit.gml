// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bloonsplit(canthit = atr.none, instant = false)
{
	if (hp == -999999.5) return;
	var shmup = false;
	var giveValue = 1;
	if (highestValue >= typeIndex)
	{
		giveValue = 1;
	}
	else
	{
		if (highestValue == -1) giveValue = -1;
		else giveValue = 0;
	}
	if (giveValue > 0)
	{
		var m = 1 * GameManager.BloonIncomeFactor * GameManager.AllIncomeFactor;
		PlayerModel.bloonFrac += m;
		PlayerModel.money += floor(PlayerModel.bloonFrac / 10000);
		PlayerModel.bloonFrac -= floor(PlayerModel.bloonFrac / 10000) * 10000;
	}
	/*
	if (typeIndex == 0)
	{
		m = 1 * 10000;
		if (PlayerModel.lifes >= GameManager.MaxLifes)
		{
			m = 0;
		}
		else if (PlayerModel.lifes >= GameManager.LifeSlowThreshold)
		{
			m *= GameManager.BloonIncomeFactor / 100;
			m /= GameManager.LifeSlowFactor;
		}
		else if (PlayerModel.lifes >= GameManager.StartingLifes)
		{
			m *= GameManager.BloonIncomeFactor / 100;
		}
		else
		{
			
		}
		PlayerModel.livesFrac += m;
		PlayerModel.lifes += floor(PlayerModel.livesFrac / 10000);
		PlayerModel.livesFrac -= floor(PlayerModel.livesFrac / 10000) * 10000;
	}*/
	var childs = [];
	var tot = 0;
	var totnonmoab = 0;
	var maxspread = 2;
	var spread = 20;
	for (var i = 0; i < array_length(BloonData.spawns); i++)
	{
		var t = BloonData.spawns[i].type;
		if (array_get_index(DataManager.BloonOrd, t) == -1)
		{
			t = string_delete(t, 1, 1);
		}
		var bloonData = DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)];
		var normalcount = BloonData.spawns[i].amt;
		var actualcount = normalcount;
		if (has(Atrs, atr.bob | atr.fort))
		{
			actualcount = floor(actualcount * 4 / 3);
		}
		if (has(Atrs, atr.ustuffed))
		{
			actualcount = actualcount * 2;
		}
		else if (has(Atrs, atr.ostuffed))
		{
			if (variable_struct_exists(BloonData.spawns[i], "")) actualcount = floor(BloonData.spawns[i].overstuffedAmt * actualcount / normalcount);
			else actualcount = floor(actualcount * 3 / 2);
		}
		
		//if (!has(bloonData.atrs, atr.moab)) actualcount = 1;
		
		tot += actualcount;
		if (!has(bloonData.atrs, atr.moab)) totnonmoab += actualcount;
	}
	if (is_struct(BloonData.moab))
	{
		maxspread = 4;
		hp = 0;
		//hp = ceil(hp / tot);
	}
	if (tot > maxspread)
	{
		spread = 20 * (maxspread - 1) / (tot - 1);
	}
	var bobBlow = false;
	if (has(Atrs, atr.bob))
	{
		bobBlow = true;
	}
	var ind = 0;
	var ind2 = 0;
	var tot2 = 1;
	var spread2 = 20;
	for (var i = 0; i < array_length(BloonData.spawns); i++)
	{
		var t = BloonData.spawns[i].type;
		var mods = int64(0);
		var bloonInd = array_get_index(DataManager.BloonOrd, t);
		if (bloonInd == -1)
		{
			mods |= getatrfromletter(string_char_at(t, 1));
			t = string_delete(t, 1, 1);
			bloonInd = array_get_index(DataManager.BloonOrd, t);
		}
		var bloonData = DataManager.BloonData[bloonInd];
		mods |= Atrs & atr.inherit;
		var ismoab = has(bloonData.atrs, atr.moab);
		var isbob = has(bloonData.atrs, atr.bob);
		if (isbob && has(Atrs, atr.stream)) { mods |= atr.camo; mods |= atr.regrow; }
		if (has(Atrs, atr.fort) && hasany(bloonData.atrs, atr.canfort))
		{
			mods |= atr.fort;
			if (isbob) mods |= atr.latex;
		}
		if (has(Atrs, atr.camo) && (!has(bloonData.atrs, atr.moab) || hasany(bloonData.atrs, atr.bob | atr.honey))) mods |= atr.camo;
		if (has(Atrs, atr.hive) && hasany(bloonData.atrs, atr.canhive)) mods |= atr.hive;
		if (GameManager.InheritanceMode)
		{
			mods |= Atrs & atr.extrainherit;
			if (ismoab) mods |= Atrs & atr.extramoabinherit;
			if (has(Atrs, atr.indigo) && typeIndex != 37 && typeIndex != 39) mods |= atr.indigo;
			if (!hasany(bloonData.atrs, atr.lead | atr.aqua | atr.crystal))
			{
				var temp = -1;
				var totalTemp = 0;
				if (has(Atrs, atr.lead))
				{
					totalTemp++;
					if (random(totalTemp) <= 1) temp = 0;
				}
				if (has(Atrs, atr.aqua))
				{
					totalTemp++;
					if (random(totalTemp) <= 1) temp = 1;
				}
				if (has(Atrs, atr.crystal))
				{
					totalTemp++;
					if (random(totalTemp) <= 1) temp = 2;
				}
				if (temp == 0) mods |= atr.lead;
				else if (temp == 1) mods |= atr.aqua;
				else if (temp == 2) mods |= atr.crystal;
			}
			if (has(Atrs, atr.black) && !has(bloonData.atrs | mods, atr.lead)) mods |= atr.black;
			if (has(Atrs, atr.white) && !has(bloonData.atrs | mods, atr.aqua)) mods |= atr.white;
			if (has(Atrs, atr.purple) && !has(bloonData.atrs | mods, atr.crystal)) mods |= atr.purple;
		}
		var vari = {parent : id, type : t, Atrs : mods, hp : hp, bloonsplitcanthit : canthit};
		if (has(Atrs, atr.regrow) || has(bloonData.atrs | mods, atr.clay))
		{
			if (variable_instance_exists(id, "regenTimer")) vari.regenTimer = regenTimer;
			if (variable_instance_exists(id, "highestRegrow")) vari.highestRegrow = highestRegrow;
			else vari.highestRegrow = typeIndex;
			if (variable_struct_exists(BloonData.spawns[i], "disambig"))
			{
				vari.regrowdisambig = BloonData.spawns[i].disambig;
			}
			else if (variable_instance_exists(id, "regrowdisambig"))
			{
				vari.regrowdisambig = regrowdisambig;
			}
		}
		if (variable_instance_exists(id, "clayLockout") && !IsMoab && hasany(bloonData.atrs | mods, atr.clay | atr.regrow))
		{
			vari.clayLockout = clayLockout;
		}
		
		var normalcount = BloonData.spawns[i].amt;
		var actualcount = normalcount;
		if (has(Atrs, atr.bob | atr.fort))
		{
			actualcount = floor(actualcount * 4 / 3);
		}
		if (has(Atrs, atr.ustuffed))
		{
			actualcount = actualcount * 2;
		}
		else if (has(Atrs, atr.ostuffed))
		{
			if (variable_struct_exists(BloonData.spawns[i], "")) actualcount = floor(BloonData.spawns[i].overstuffedAmt * actualcount / normalcount);
			else actualcount = floor(actualcount * 3 / 2);
		}
		
		//if (!has(bloonData.atrs, atr.moab)) actualcount = 1;
		
		if (ismoab && !bobBlow)
		{
			ind2 = 0;
			tot2 = actualcount;
			spread2 = 20;
			if (tot2 > maxspread)
			{
				spread2 = 20 * (maxspread - 1) / (tot2 - 1);
			}
		}
		for (var j = 0; j < actualcount; j++)
		{
			if (giveValue > 0)
			{
				if (j >= normalcount) vari.highestValue = -1;
				else vari.highestValue = highestValue;
			}
			else if (giveValue == 0)
			{
				if (bloonData.downstream[highestValue])
				{
					vari.highestValue = highestValue;
					giveValue = -1;
				}
				else vari.highestValue = -1;
			}
			else
			{
				vari.highestValue = -1;
			}
			if (bobBlow)
			{
				if (shmup) {
					vari.dir = dir + random_range(0, 360);
					array_push(childs, instance_create_layer(x, y, "Bloons", ShmupBloon, vari));
				} else {
					vari.path = path;
					vari.patht = patht + random_range(-60, 60);
					array_push(childs, instance_create_layer(x, y, "Bloons", TrackBloon, vari));
				}
			}
			else if (ismoab)
			{
				if (shmup) {
					vari.dir = dir + random_range(-3, 3);
					array_push(childs, instance_create_layer(x + spread2 * dcos(dir) * (ind2 - tot2 / 2 + 1/2), y + spread2 * dsin(dir) * (ind2 - tot2 / 2 + 1/2), "Bloons", ShmupBloon, vari));
				} else {
					vari.path = path;
					vari.patht = patht + spread2 * (ind2 - tot2 / 2 + 1/2);
					array_push(childs, instance_create_layer(x, y, "Bloons", TrackBloon, vari));
				}
				ind2++;
			}
			else
			{
				if (shmup) {
					vari.dir = dir + random_range(-3, 3);
					array_push(childs, instance_create_layer(x + spread * dcos(dir) * (ind - tot / 2 + 1/2), y + spread * dsin(dir) * (ind - tot / 2 + 1/2), "Bloons", ShmupBloon, vari));
				} else {
					vari.path = path;
					vari.patht = patht + spread * (ind - tot / 2 + 1/2);
					array_push(childs, instance_create_layer(x, y, "Bloons", TrackBloon, vari));
				}
				ind++;
			}
		}
	}
	if (!instant) playpopsound(id);
	instance_destroy();
	hp = -999999.5;
	return childs;
}

function getregrownext(t, highest, disambig = -1, data = -1)
{
	if (highest == -1) highest = 99;
	if (t >= highest) return -1;
	if (t >= 25) return -1;
	if (t == 4) // Pink
	{
		if (highest == 7 || highest == 17 || highest == 19) return 7; // Purple
	}
	if (data == -1) data = DataManager.BloonData[t];
	if (disambig != -1 && variable_struct_exists(data, "regrowdisambiguation")) return array_get_index(DataManager.BloonOrd, data.regrowdisambiguation[disambig]);
	switch (t)
	{
		case 1: // Blue
			if (highest >= 99) return 2; // Green
			if (highest >= 12 && !(highest >= 16 && highest <= 20)) return 12; // Violet
			return 2; // Green
		case 2: // Green
			if (highest >= 99) return 3; // Yellow
			if (highest >= 12 && !(highest >= 16 && highest <= 20)) return 13; // Teal
			return 3; // Yellow
		case 3: // Yellow
			if (highest >= 99) return 4; // Pink
			if (highest >= 12 && !(highest >= 16 && highest <= 20)) return 14; // Lime
			return 4; // Pink
		case 4: // Pink
			if (highest >= 99) return 5; // Black
			if (highest == 5 || highest == 9 || highest == 18) return 5; // Black
			if (highest == 6 || highest == 16 || highest == 20) return 6; // White
			if (highest == 7 || highest == 17 || highest == 19) return 7; // Purple
			if (highest >= 12) return 15; // Orange
			return 5; // Black
		case 5: // Black
			if (highest == 9 || highest == 18) return 9; // Lead
			return 8; // Zebra
		case 6: // White
			if (highest == 16 || highest == 20) return 16; // Aqua
			return 8; // Zebra
		case 7: return 17; // Purple > Crystal
		case 8: return 10; // Zebra > Rainbow
		case 9: return 18; // Lead > Titanium
		case 11: return 24; // Ceramic > Brick
		case 15: // Orange
			if (highest == 23 || highest == 24) return 23; // Clay
			return 21; // Indigo
		case 16: return 20; // Aqua > Ice
		case 17: return 19; // Crystal > Amber
		case 18: // Titanium
		case 19: // Amber
		case 20: // Ice
		case 22: // Hex
		case 24: // Brick
			return -1;
	}
	return t + 1;
}

function calculatespriteindex(t, atrs = -1)
{
	if (!is_numeric(t)) t = array_get_index(DataManager.BloonOrd, t);
	if (t == -1) return atr.none;
	if (atrs == -1)
	{
		atrs = DataManager.BloonData[t].atrs;
	}
	atrs &= atr.spriteindexed;
	atrs |= int64(t) << 32;
	return atrs;
}

function extracttypefromspriteindex(sprindex)
{
	return real(sprindex >> 32);
}

function calculateuniquebloonidentifier(t, atrs = -1, growdisambiguation = 0)
{
	if (!is_numeric(t)) t = array_get_index(DataManager.BloonOrd, t);
	if (t == -1) return atr.none;
	if (atrs == -1)
	{
		atrs = DataManager.BloonData[t].atrs;
	}
	atrs |= int64(t) << 36;
	if (growdisambiguation > 0 && has(atrs, atr.regrow)) atrs |= int64(growdisambiguation) << 32;
	return atrs;
}

function extracttypefrombloonidentifier(ident)
{
	return real(ident >> 36);
}

function extractdisambiguationfrombloonidentifier(ident)
{
	return real(ident >> 32) % 16;
}

function extractatrsfrombloonidentifier(ident)
{
	return ident | atr.allall;
}