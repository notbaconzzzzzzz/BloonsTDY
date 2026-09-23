/// @description Insert description here
// You can write your code in this editor
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
		if (has(Upgrades, upg.e4))
		{
			vari.destroyoncanthit = false;
			vari.forgivingamber = 0.5;
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
				doubleDart = 0;
			}
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
		var ty = target.y + target.posoffset - y;
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
			instance_create_layer(x - 2 * ProjRad * dsin(d) * (i - (shots - 1) / 2), y + 2 * ProjRad * dcos(d) * (i - (shots - 1) / 2), "Projectiles", Projectile, vari);
		}
		if (AttackSpeed.per) attackDelay += 3600;
		else attackDelay = AttackSpeed.val;
	}
	else
	{
		attackDelay = 0;
	}
}