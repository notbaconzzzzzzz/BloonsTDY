/// @description Insert description here
// You can write your code in this editor
/*
x += xv;
y += yv;
if (x < 0 || x > room_width || y < 0 || y > room_height)
{
	instance_destroy();
}*/
if (pierce <= 0) return;
hitdetection(x, y, rad, "radial", function(inst)
{
	if (!instance_exists(inst)) return false;
	dmg = damage;
	dmgmult = damagemult;
	for (var i = 0; i < array_length(cond); i++)
	{
		cond[i](inst, id);
	}
	dmg = round(dmg * dmgmult);
	if (has(inst.Atrs, atr.kant))
	{
		if (pierce < 2) { pierce = 0; playbloonsound(blnsnd.hitkant); return true; }
		pierce -= 1;
	}
	if (has(inst.Atrs, atr.amber))
	{
		pierce = floor(pierce * forgivingamber);
	}
	if (has(cantHits, atr.camo) && has(inst.Atrs, atr.camo))
	{
		return false;
	}
	var flag = false;
	if (has(cantHits, atr.clay) && has(inst.Atrs, atr.clay))
	{
		if (inst.IsMoab ? (inst.clayLockout <= inst.MaxHp - inst.hp) : (!variable_instance_exists(inst, "clayLockout") || inst.clayLockout & (int64(1) << inst.typeIndex) == 0))
		{
			flag = true;
			//inst.clayCooldown = 120;
			if (mibratio > 0)
			{
				if (dmg > 1) dmg = ceil(dmg * mibratio / 100);
				else pierce -= ceil(100 / mibratio) - 1;
			}
			else
			{
				playbloonsound(blnsnd.hitclay);
			
				with (inst)
				{
					if (!is_int64(clayLockout))
					{
						var heal = floor(25 * power(3, (is_struct(BloonData.moab) ? BloonData.moab.class : 0) - 1));
						if (heal + other.dmg > MaxHp - clayLockout) heal = MaxHp - clayLockout - other.dmg;
						if (heal + hp > MaxHp) heal = MaxHp - hp;
						hp += heal;
						clayLockout += heal + other.dmg;
					}
					else
					{
						clayLockout |= int64(1) << typeIndex;
						var highre = variable_instance_exists(id, "highestRegrow") ? highestRegrow : -1;
						if (highre == typeIndex) highre = -1;
						var growinto = getregrownext(typeIndex, highre, variable_instance_exists(id, "regrowdisambig") ? regrowdisambig : -1, BloonData);
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
									else if (highestRegrow < typeIndex) clayLockout |= int64(1) << typeIndex;
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
						else
						{
							clayLockout |= int64(1) << typeIndex;
						}
					}
				}
				dmg = 0;
			
				if (cantHits & (inst.Atrs & ~atr.camo & ~atr.clay) != atr.none)
				{
					if (destroyoncanthit)
					{
						pierce = 0;
						return true;
					}
				}
			}
		}
	}
	if (cantHits & (inst.Atrs & ~atr.camo & ~atr.clay) != atr.none && !flag)
	{
		if (mibratio > 0)
		{
			if (dmg > 1) dmg = ceil(dmg * mibratio / 100);
			else pierce -= ceil(100 / mibratio) - 1;
		}
		else
		{
			playcanthitsound(cantHits & inst.Atrs);
			dmg = 0;
			if (destroyoncanthit)
			{
				pierce = 0;
				return true;
			}
		}
	}
	if (has(inst.Atrs, atr.hah))
	{
		if (dmg >= 25) dmg = floor(dmg / 5);
		else dmg = floor(sqrt(dmg));
	}
	if (has(inst.Atrs, atr.titan))
	{
		if (dmg > 0)
		{
			dmg -= 1;
			if (dmg <= 0) playbloonsound(blnsnd.hittitan);
		}
	}
	pierce -= 1;
	var childs = -1;
	with (inst)
	{
		hp -= other.dmg;
		if (hp <= 0) childs = bloonsplit(other.cantHits);
		else playdmgsound(inst);
	}
	var result = false;
	for (var i = 0; i < array_length(afterHit); i++)
	{
		if (afterHit[i](inst, childs, id))
		{
			result = true;
		}
	}
	if (result || pierce <= 0) return true;
	return false;
});
/*
with (ShmupBloon)
{
	if (other.pierce > 0 && hp > 0 && sqr(x - other.x) + sqr(y - other.y) <= sqr(rad + other.rad))
	{
		var flag = true;
		for (var i = 0; i < array_length(parentInstances); i++)
		{
			if (array_contains(other.hitInstances, parentInstances[i]))
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			var dmg = 1;
			if (array_contains(BloonData.atr, "moab")) dmg += 2;
			if (array_contains(BloonData.atr, "hah")) dmg = floor(sqrt(dmg));
			if (array_contains(BloonData.atr, "titanium")) dmg -= 1;
			if (array_contains(BloonData.atr, "kant"))
			{
				if (other.pierce < 10) dmg = 0;
				other.pierce -= 9;
			}
			if (array_contains(BloonData.atr, "amber"))
			{
				other.pierce = 0;
			}
			other.pierce -= 1;
			hp -= dmg;
			array_push(other.hitInstances, id);
			if (hp <= 0) bloonsplit();
		}
	}
}*/
//if (pierce <= 0) instance_destroy();