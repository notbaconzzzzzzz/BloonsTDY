/// @description Insert description here
// You can write your code in this editor
var attackingFlag = true;
if (attackDelay > 0)
{
	if (AttackSpeed.per) attackDelay -= AttackSpeed.valper;
	else attackDelay -= 1;
}
else
{
	var target = bloondetection(x, y, detectionrange, "radial", !has(CantHits, atr.camo));
	if (target != noone)
	{
		var vari = {owner : id, rad : ProjRad, pierce : Pierce, damage : Damage, damagemult : DamageMult, cantHits : CantHits, cond : Cond, afterHit : AfterHit, tick : Tick};
		var isCrit = false;
		var isSuperCrit = false;
		var isDouble = false;
		var isAirburst = false;
		var shots = Shots;
		var spread = Spread;
		var offset = 0;
		if (has(Upgrades, upg.e4))
		{
			vari.destroyoncanthit = false;
			vari.forgivingamber = 0.5;
		}
		if (bloontoniumCharges > 0)
		{
			bloontoniumCharges -= 1;
			if (!has(Upgrades, upg.c4)) vari.damage += 1;
			if (has(Upgrades, upg.c3)) vari.pierce += 1;
			vari.cantHits &= !(atr.lead | atr.aqua | atr.crystal | atr.frozen);
		}
		if (CritDartInterval != -1)
		{
			critDart++;
			if (critDart >= CritDartInterval)
			{
				isCrit = true;
				vari.damage += CritDartDmg;
				critDart = 0;
				if (SuperCritInterval != -1)
				{
					superCrit++;
					if (superCrit >= SuperCritInterval)
					{
						isSuperCrit = true;
						vari.damage += SuperCritDmg;
						vari.pierce += SuperCritPierce;
						superCrit = 0;
					}
				}
			}
		}
		if (DoubleDartInterval != -1)
		{
			doubleDart++;
			if (doubleDart >= DoubleDartInterval)
			{
				isDouble = true;
				shots += DoubleDartShots;
				spread = 0;
				offset = 2 * ProjRad;
				doubleDart = 0;
			}
		}
		if (has(Upgrades, upg.e3))
		{
			if (isDouble) offset = 1.5 * ProjRad;
			else offset = 1 * ProjRad;
		}
		if (AirburstInterval != -1)
		{
			airburst++;
			if (airburst >= AirburstInterval)
			{
				isAirburst = true;
				airburst = 0;
			}
		}
		vari.crit = isCrit;
		vari.airburst = isAirburst;
		//spread /= shots;
		var tx = target.x - x;
		var ty = target.y - y;
		//ty += target.posoffset;
		var dist = sqrt(sqr(tx) + sqr(ty));
		var spd = Velocity;
		if (isCrit) spd *= 1.25;
		tx += target.xv * dist / 20 / 2;
		ty += target.yv * dist / 20 / 2;
		var d = darctan2(ty, tx);
		vari.spd = spd;
		vari.lifetime = traveldistance / spd;
		for (var i = 0; i < shots; i++)
		{
			vari.dir = d + spread * (i - (shots - 1) / 2);
			instance_create_layer(x - offset * dsin(d) * (i - (shots - 1) / 2), y + offset * dcos(d) * (i - (shots - 1) / 2), "Projectiles", Projectile, vari);
		}
		if (AttackSpeed.per) attackDelay += 3600;
		else attackDelay = AttackSpeed.val;
	}
	else
	{
		attackDelay = 0;
		attackingFlag = false;
	}
}

if (attackingFlag)
{
	if (has(Upgrades, upg.c4))
	{
		reactorTimer += 1;
		if (reactorTimer >= 180 - catalystStacks * 15)
		{
			reactorTimer = 0;
			if (catalystStacks < 4)
			{
				catalystStacks += 1;
				AttackSpeedCalcs.catalyst = asbth(3600 / (60 + 15 * catalystStacks), 60 + 15 * catalystStacks);
				calculateattackspeed();
			}
			with (Tower)
			{
				if (id == other) continue;
				if (point_distance(other.x, other.y, x, y) > detectionrange + 0.5) continue;
				if (bloontoniumCharges < 15 - 5) bloontoniumCharges += 5;
				if (bloontoniumCharges < 15) bloontoniumCharges = 15;
				bloontoniumTimer = 0;
			}
		}
	}
	catalystTimer = 0;
}
else
{
	if (catalystStacks > 0)
	{
		catalystTimer += 1;
		if (catalystTimer >= 360)
		{
			catalystStacks = 0;
			AttackSpeedCalcs.catalyst = asbth(60, 60);
			calculateattackspeed();
		}
	}
	if (reactorTimer > 0) reactorTimer -= 1;
}
if (bloontoniumCharges > 0)
{
	bloontoniumTimer += 1;
	if (bloontoniumTimer >= 720)
	{
		bloontoniumTimer = 0;
		bloontoniumCharges = floor(bloontoniumCharges / 2);
	}
}