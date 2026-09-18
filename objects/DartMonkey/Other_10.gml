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
		var isCrit = false;
		var isDouble = false;
		var isAirburst = false;
		var shots = Shots;
		var spread = Spread;
		if (CritDartInterval != -1)
		{
			critDart++;
			if (critDart >= CritDartInterval)
			{
				isCrit = true;
				critDart = 0;
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
		//spread /= shots;
		var tx = target.x - x;
		var ty = target.y - y;
		var dist = sqrt(sqr(tx) + sqr(ty));
		var spd = Velocity;
		if (isCrit) spd *= 1.25;
		tx += target.xv * dist / 20 / 2;
		ty += target.yv * dist / 20 / 2;
		var d = darctan2(ty, tx);
		for (var i = 0; i < shots; i++)
		{
			instance_create_layer(x - 2 * ProjRad * dsin(d) * (i - (shots - 1) / 2), y + 2 * ProjRad * dcos(d) * (i - (shots - 1) / 2), "Projectiles", Projectile, {owner : id, crit : isCrit, airburst : isAirburst, dir : d + spread * (i - (shots - 1) / 2), spd : spd, lifetime : traveldistance / spd, rad : ProjRad, pierce : Pierce + (isCrit ? CritDartPierce : 0), damage : Damage + (isCrit ? CritDartDmg : 0), damagemult : DamageMult, cantHits : CantHits, cond : Cond, afterHit : AfterHit, tick : Tick});
		}
		if (AttackSpeed.per) attackDelay += 3600;
		else attackDelay = AttackSpeed.val;
	}
	else
	{
		attackDelay = 0;
	}
}