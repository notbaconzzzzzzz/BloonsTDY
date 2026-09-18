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
	if (has(cantHits, atr.clay) && has(inst.Atrs, atr.clay))
	{
		if (mibratio > 0)
		{
			if (dmg > 1) dmg = ceil(dmg * mibratio / 100);
			else pierce -= ceil(100 / mibratio) - 1;
		}
		else
		{
			playbloonsound(blnsnd.hitclay);
			dmg = 0; // make regen
			if (cantHits & inst.Atrs != atr.none)
			{
				if (destroyoncanthit)
				{
					pierce = 0;
					return true;
				}
			}
		}
	}
	else if (cantHits & inst.Atrs != atr.none)
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
		if (hp <= 0) childs = bloonsplit();
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