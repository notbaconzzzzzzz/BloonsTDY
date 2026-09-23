/// @description Insert description here
// You can write your code in this editor
if (hp <= 0 && instance_exists(id))
{
	bloonsplit();
	return;
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
					Atrs &= atr.allinherit;
					Atrs |= BloonData.atrs;

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
