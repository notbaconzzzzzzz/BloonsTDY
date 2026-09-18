// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function bloonsplit(instant)
{
	var shmup = false;
	var m = 1 * GameManager.BloonIncomeFactor * GameManager.AllIncomeFactor;
	PlayerModel.bloonFrac += m;
	PlayerModel.money += floor(PlayerModel.bloonFrac / 10000);
	PlayerModel.bloonFrac -= floor(PlayerModel.bloonFrac / 10000) * 10000;
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
		tot += BloonData.spawns[i].amt;
		if (!has(DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)].atrs, atr.moab)) totnonmoab += BloonData.spawns[i].amt;
	}
	if (has(Atrs, atr.moab))
	{
		maxspread = 4;
		hp = 0;
		//hp = ceil(hp / tot);
	}
	if (tot > maxspread)
	{
		spread = 20 * (maxspread - 1) / (tot - 1);
	}
	if (has(Atrs, atr.bob))
	{
		for (var i = 0; i < array_length(BloonData.spawns); i++)
		{
			var t = BloonData.spawns[i].type;
			var mods = int64(0);
			if (array_get_index(DataManager.BloonOrd, t) == -1)
			{
				mods |= getatrfromletter(string_char_at(t, 1));
				t = string_delete(t, 1, 1);
			}
			mods |= Atrs & atr.inherit;
			var isbob = has(DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)].atrs, atr.bob);
			if (isbob && has(Atrs, atr.stream)) { mods |= atr.camo; mods |= atr.regrow; }
			if (has(Atrs, atr.fort) && hasany(DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)].atrs, atr.canfort))
			{
				mods |= atr.fort;
				if (isbob) mods |= atr.latex;
			}
			if (has(Atrs, atr.hive) && hasany(DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)].atrs, atr.canhive)) mods |= atr.hive;
			var vari = {parent : id, type : t, Atrs : mods, hp : hp};
			if (has(Atrs, atr.regrow))
			{
				vari.regenTimer = regenTimer;
				vari.highestRegrow = highestRegrow;
			}
			
			for (var j = 0; j < BloonData.spawns[i].amt; j++)
			{
				if (shmup)
				{
					vari.dir = dir + random_range(0, 360);
					array_push(childs, instance_create_layer(x, y, "Bloons", ShmupBloon, vari));
				}
				else
				{
					vari.path = path;
					vari.patht = patht + random_range(-60, 60);
					array_push(childs, instance_create_layer(x, y, "Bloons", TrackBloon, vari));
				}
			}
		}
	}
	else
	{
		var ind = 0;
		for (var i = 0; i < array_length(BloonData.spawns); i++)
		{
			var t = BloonData.spawns[i].type;
			var mods = int64(0);
			if (array_get_index(DataManager.BloonOrd, t) == -1)
			{
				mods |= getatrfromletter(string_char_at(t, 1));
				t = string_delete(t, 1, 1);
			}
			mods |= Atrs & atr.inherit;
			var isbob = has(DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)].atrs, atr.bob);
			if (isbob && has(Atrs, atr.stream)) { mods |= atr.camo; mods |= atr.regrow; }
			if (has(Atrs, atr.fort) && hasany(DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)].atrs, atr.canfort))
			{
				mods |= atr.fort;
				if (isbob) mods |= atr.latex;
			}
			if (has(Atrs, atr.hive) && hasany(DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)].atrs, atr.canhive)) mods |= atr.hive;
			var vari = {parent : id, type : t, Atrs : mods, hp : hp};
			if (has(Atrs, atr.regrow))
			{
				vari.regenTimer = regenTimer;
				vari.highestRegrow = highestRegrow;
			}
			
			var ismoab = has(DataManager.BloonData[array_get_index(DataManager.BloonOrd, t)].atrs, atr.moab);
			if (ismoab)
			{
				var ind2 = 0;
				var tot2 = BloonData.spawns[i].amt;
				var spread2 = 20;
				if (tot2 > maxspread)
				{
					spread2 = 20 * (maxspread - 1) / (tot2 - 1);
				}
				for (var j = 0; j < BloonData.spawns[i].amt; j++)
				{
					if (shmup)
					{
						vari.dir = dir + random_range(-3, 3);
						array_push(childs, instance_create_layer(x + spread2 * dcos(dir) * (ind2 - tot2 / 2 + 1/2), y + spread2 * dsin(dir) * (ind2 - tot2 / 2 + 1/2), "Bloons", ShmupBloon, vari));
					}
					else
					{
						vari.path = path;
						vari.patht = patht + spread2 * (ind2 - tot2 / 2 + 1/2);
						array_push(childs, instance_create_layer(x, y, "Bloons", TrackBloon, vari));
					}
					ind2++;
				}
			}
			else
			{
				for (var j = 0; j < BloonData.spawns[i].amt; j++)
				{
					if (shmup)
					{
						vari.dir = dir + random_range(-3, 3);
						array_push(childs, instance_create_layer(x + spread * dcos(dir) * (ind - tot / 2 + 1/2), y + spread * dsin(dir) * (ind - tot / 2 + 1/2), "Bloons", ShmupBloon, vari));
					}
					else
					{
						vari.path = path;
						vari.patht = patht + spread * (ind - tot / 2 + 1/2);
						array_push(childs, instance_create_layer(x, y, "Bloons", TrackBloon, vari));
					}
					ind++;
				}
			}
		}
	}
	if (!instant) playpopsound(id);
	instance_destroy();
	return childs;
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