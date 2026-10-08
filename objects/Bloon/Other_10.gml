/// @description Insert description here
// You can write your code in this editor
if (hp <= 0 && instance_exists(id))
{
	bloonsplit();
	return;
}
if (IsMoab && has(Atrs, atr.hive))
{
	hiveTimer += 1;
	if (hiveTimer >= HiveInterval)
	{
		hiveTimer -= HiveInterval;
		var hpstate = clamp(5 - ceil(5 * hp / MaxHp), 0, 4);
		hivespawn(hpstate);
	}
}
if (has(Atrs, atr.regrow))
{
	if (highestRegrow != typeIndex || (highestRegrow == -1 && hp < MaxHp))
	{
		regenTimer += 1;
		if (regenTimer >= 180)
		{
			if (highestRegrow == -1)
			{
				hp += 5 * power(3, is_struct(BloonData.moab) ? BloonData.moab.class : 0);
				if (hp > MaxHp) hp = MaxHp;
			}
			else
			{
				var growinto = getregrownext(typeIndex, highestRegrow, variable_instance_exists(id, "regrowdisambig") ? regrowdisambig : -1, BloonData);
				if (growinto != -1)
				{
					typeIndex = growinto;
					type = DataManager.BloonOrd[typeIndex];
					BloonData = DataManager.BloonData[typeIndex];
					var tempAtrs = Atrs;
					Atrs = BloonData.atrs;
					Atrs |= tempAtrs & atr.allinherit;
					if (GameManager.InheritanceMode)
					{
						Atrs |= tempAtrs & atr.extrainherit;
						if (has(Atrs, atr.moab)) Atrs |= tempAtrs & atr.extramoabinherit;
						if (has(tempAtrs, atr.indigo)) Atrs |= atr.indigo;
						if (!hasany(Atrs, atr.lead | atr.aqua | atr.crystal))
						{
							var temp = -1;
							var totalTemp = 0;
							if (has(tempAtrs, atr.lead))
							{
								totalTemp++;
								if (random(totalTemp) <= 1) temp = 0;
							}
							if (has(tempAtrs, atr.aqua))
							{
								totalTemp++;
								if (random(totalTemp) <= 1) temp = 1;
							}
							if (has(tempAtrs, atr.crystal))
							{
								totalTemp++;
								if (random(totalTemp) <= 1) temp = 2;
							}
							if (temp == 0) Atrs |= atr.lead;
							else if (temp == 1) Atrs |= atr.aqua;
							else if (temp == 2) Atrs |= atr.crystal;
						}
						if (has(tempAtrs, atr.black) && !has(Atrs, atr.lead)) Atrs |= atr.black;
						if (has(tempAtrs, atr.white) && !has(Atrs, atr.aqua)) Atrs |= atr.white;
						if (has(tempAtrs, atr.purple) && !has(Atrs, atr.crystal)) Atrs |= atr.purple;
					}

					MaxHp = BloonData.hp;
					Spd = BloonData.spd;
					if (has(Atrs, atr.latex))
					{
						if (has(Atrs, atr.moab))
						{
							switch (is_struct(BloonData.moab) ? BloonData.moab.class : 1)
							{
								case 0: MaxHp += 5; break;
								case 1: MaxHp += 25; break;
								case 2: MaxHp += 100; break;
								case 3: MaxHp += 400; break;
								case 4: MaxHp += 1500; break;
							}
						}
						else MaxHp += 1;
					}
					if (has(Atrs, atr.fort))
					{
						if (has(Atrs, atr.hardy))
						{
							MaxHp += 1;
							Atrs |= atr.hard;
						}
						MaxHp *= 2;
					}
					if (has(Atrs, atr.mega)) MaxHp *= 10;
					if (has(Atrs, atr.stream))
					{
						if (is_struct(BloonData.moab)) Spd += BloonData.moab.stream;
						else Spd += 100;
					}
					if (has(Atrs, atr.clay))
					{
						if (IsMoab)
						{
							clayLockout = 0;
						}
						else
						{
							if (!variable_instance_exists(id, "clayLockout") || !is_int64(clayLockout))
							{
								clayLockout = int64(0);
							}
							if (!variable_instance_exists(id, "highestRegrow")) highestRegrow = typeIndex;
						}
					}

					if (has(Atrs, atr.moab)) MaxHp = round(MaxHp * GameManager.MoabHpFactor / 100);
					else if (has(Atrs, atr.hard)) MaxHp = round(MaxHp * GameManager.HardHpFactor / 100);
					Spd = round(Spd * GameManager.SpeedFactor / 100);

					if (has(Atrs, atr.moab))
					{
						blimp = true;
						if (type == "bob" || type == "bobmega") blimp = false;
						else if (type == "honey1" || type == "honey2" || type == "honey3" || type == "honey4" || type == "honey5") blimp = false;
					}
					else
					{
						blimp = false;
					}
					rad = BloonData.size / 2;

					hp = MaxHp;
					var sprind = calculatespriteindex(typeIndex, Atrs);
					var spr = BloonRenderer.BloonSprites[? sprind];
					if (is_undefined(spr))
					{
						sprite_index = -1;
						if (!array_contains(BloonRenderer.drawQueue, sprind)) array_push(BloonRenderer.drawQueue, sprind);
					}
					else sprite_index = spr;
					if (has(Atrs, atr.regrow)) rad *= 1.25;
				}
			}
			regenTimer -= 180;
		}
	}
	else
	{
		regenTimer = 0;
	}
}

var newBloonRegion = calculatebloonregion(x, y, IsMoab);
if (newBloonRegion != bloonRegion)
{
	bloonRegion = newBloonRegion;
	bloonRegionNode.Migrate(GameManager.bloonRegions[bloonRegion]);
}
