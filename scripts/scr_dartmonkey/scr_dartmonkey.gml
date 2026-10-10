// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function DartMonkey_basestats()
{
	CantHits = atr.canthits;
	Cond = [];
	AfterHit = [];
	Tick = [];
	Range = 20;
	Damage = 1;
	DamageMult = 1;
	Pierce = 2;
	Velocity = 20;
	TravelRatio = 12;
	ProjRad = 10;
	AttackSpeedCalcs = {base : asf(57)};

	CritDartInterval = -1;
	CritDartDmg = 0;
	SuperCritInterval = -1;
	SuperCritDmg = 0;
	SuperCritPierce = 0;
	DoubleDartInterval = -1;
	DoubleDartShots = 1;
	AirburstInterval = -1;
	AirburstShots = 2;
	AirburstSpread = 20;
	AirburstVelocity = 30;
	AirburstTravelDistance = 120;
	Shots = 1;
	Spread = 40;
	
	calculaterange();
	calculateattackspeed();
}

function DartMonkey_initstats()
{
	DartMonkey_basestats();
	
	TowerData = { ups : [[
	{
		name : "Sharp Shots",
		price : 140,
		desc : "+1 Pierce",
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Razor Sharp Shots",
		desc : "+2 Pierce",
		price : 220,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Long Range Darts",
		desc : "+5 Range",
		price : 90,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Enhanced Eyesight",
		desc : "+5 Range, can pop Camo",
		price : 200,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Crossbow",
		desc : "+2 Damage, +1 Pierce, +5 Range\nSlower base Attack Speed (1.100s),\nShoot Crossbow Bolts that have smaller size and faster velocity\n+1 Damage against MOABs",
		price : 625,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Sharp Shooter",
		desc : "+1 Damage, +2 Range, +25% Attack Speed\nCan pop Frozen, +1 Damage against MOABs\nAfter traveling a certain distance (150 units), bolts gain x2 Damage\n[Spike-o-pult] ^ +3 Damage instead of x2",
		price : 5250,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Critical Darts",
		desc : "Every 4th attack Crits, and gains: +1 Damage\n[Crossbow] Crits gain: +3 Damage instead\n(Sharpshooter) Every 3rd Crit gains: +8 Damage, +2 Pierce instead",
		price : 150,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Double Darts",
		desc : "Every 3rd attack shoots 2 projectiles in parellel\n[Triple Shot] +25% Attack Speed, every 3rd attack has 0 Spread instead",
		price : 210,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Bloontonium Darts",
		desc : "+1 Damage (no longer Crits)\n[Spike-o-pult] +2 Damage instead\nCan pop Lead, Aqua, Crystal, Frozen\n(Crossbow) Every 5th attack Crits, and gains: +5 Damage\n(Sharpshooter) Every 3rd Crit gains: +25 Damage, +4 Pierce instead\nGains +1 Pierce from Bloontonium Charges",
		price : 550,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Bloontonium Radiator",
		desc : "+1 Damage (does not gain Damage from Bloontonium Charges)\nEvery 3s while attacking, trigger Radiator:\nRadiator: Grant all other Towers in Range 5 Bloontonium Charges\n Bloontonium Charges: Spend 1 Charge to gain +1 Damage, the ability to pop Lead, Aqua, Crystal, Frozen;\nCap of 15 Charges, lose half of the Charges every 12s\nRadiator: Gain 1 Catalyst: +25% Attack Speed, -0.25s Radiator Interval, stacks up to 4 times,\nlose all Catalyst after 4s on not attacking\nHas ACTIVE Ability that is currently not implemented",
		price : 10800,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Quick Shots",
		desc : "+18% Attack Speed",
		price : 100,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Very Quick Shots",
		desc : "+27% Attack Speed",
		price : 190,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Triple Shot",
		desc : "-12% Attack Speed\nAttack shoots 3 Darts with a Spread of 40\n(Airburst Darts) Spread of 30\n(Spike-o-pult) -33% Attack Speed, Spread of 10",
		price : 500,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Super Monkey Fan Club",
		desc : "+50% Attack Speed\n[Double Darts] +33% Attack Speed instead\n[Spike-o-pult] +67% Attack Speed instead\nHas ACTIVE Ability that is currently not implemented",
		price : 3000,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Spike-O-Pult",
		desc : "+1 Damage, +20 Pierce\nCan pop Frozen\nMuch slower base Attack Speed (1.250s),\nShoot Spike Balls that have larger size, slower velocity, and much longer lifetime",
		price : 450,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Juggernaut",
		desc : "+40 Pierce, +11% Attack Speed\nCan pop Lead\nSpike Balls have larger size, faster velocity, and longer lifetime\n +3 Damage against Ceramic, +2 against Fortified\nProjectile does not get destroyed when hitting a Bloon that it cannot pop\nAmber only reduces half of remaining Pierce",
		price : 3600,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Airburst Darts",
		desc : "+1 Pierce, +12% Attack Speed\nCan pop Aqua\nEvery 3rd Attack is Airbursting: Spawns 2 Darts with 20 Spread each time it hits a Bloon\n(Triple Shot) Airbursting Darts spawn 3 Darts with 30 Spread instead",
		price : 725,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}]] };
}

function DartMonkey_restats()
{
	DartMonkey_basestats();
	
	// Projectile changes
	if (has(Upgrades, upg.e4))
	{ // Juggernaut
		AttackSpeedCalcs.base = asf(75);
		TravelRatio = 72;
		Velocity = 18;
		AirburstVelocity = 27;
		ProjRad = 40;
		if (has(Upgrades, upg.b3))
		{ // Juggernaut Ballista?
			Velocity = 24;
			AirburstVelocity = 36;
			ProjRad = 32;
		}
	}
	else if (has(Upgrades, upg.e3))
	{ // Spike-O-Pult
		AttackSpeedCalcs.base = asf(75);
		TravelRatio = 36;
		Velocity = 15;
		AirburstVelocity = 22.5;
		ProjRad = 20;
		if (has(Upgrades, upg.b3))
		{ // Ballista
			Velocity = 20;
			AirburstVelocity = 30;
			ProjRad = 16;
		}
	}
	else if (has(Upgrades, upg.b3))
	{ // Crossbow
		AttackSpeedCalcs.base = asf(66);
		Velocity = 24;
		AirburstVelocity = 36;
		ProjRad = 8;
	}
	
	// T1 T2
	if (has(Upgrades, upg.a1))
	{ // Sharp Shots
		Pierce += 1;
	}
	if (has(Upgrades, upg.a2))
	{ // Razor Sharp Shots
		Pierce += 2;
	}
	if (has(Upgrades, upg.b1))
	{ // Long Range Darts
		Range += 5;
	}
	if (has(Upgrades, upg.b2))
	{ // Enhanced Eyesight
		Range += 5;
		CantHits &= ~atr.camo;
	}
	if (has(Upgrades, upg.c1))
	{ // Critical Darts
		CritDartInterval = 4;
		CritDartDmg = 1;
		if (has(Upgrades, upg.b3))
		{
			CritDartDmg = 3;
		}
		if (has(Upgrades, upg.b4))
		{
			SuperCritInterval = 3;
			SuperCritDartDmg = 5;
			SuperCritDartPierce = 2;
		}
	}
	if (has(Upgrades, upg.c2))
	{ // Double Darts
		DoubleDartInterval = 3;
		DoubleDartShots = 1;
	}
	if (has(Upgrades, upg.d1))
	{ // Quick Shots
		AttackSpeedCalcs.a = asf(51);
	}
	if (has(Upgrades, upg.d2))
	{ // Very Quick Shots
		AttackSpeedCalcs.a = asf(40);
	}
	
	// T3 T4
	if (has(Upgrades, upg.a3))
	{ // Tricky Shots
		Range += 3;
		AttackSpeedCalcs.b = asf(57);
		Velocity += 2;
		AirburstVelocity += 3;
		// MISSING Bounce
		// MISSING Trick Shot
	}
	if (has(Upgrades, upg.a4))
	{ // Puppeteer of Fate
		Pierce += 3;
		if (has(Upgrades, upg.e3))
		{
			Pierce += 2;
			AttackSpeedCalcs.b = asf(48);
		}
		Velocity += 8;
		AirburstVelocity += 12;
		CantHits &= ~atr.crystal;
		CantHits &= ~atr.frozen;
		// MISSING Redirection
	}
	
	if (has(Upgrades, upg.b3))
	{ // Crossbow
		Damage += 2;
		Pierce += 1;
		Range += 5;
		array_push(Cond, function(inst2, proj) {
			if (has(inst2.Atrs, atr.moab)) proj.dmg += 1;
		});
	}
	if (has(Upgrades, upg.b4))
	{ // Sharp Shooter
		Damage += 1;
		Range += 2;
		AttackSpeedCalcs.b = asf(48);
		if (has(Upgrades, upg.a3)) AttackSpeedCalcs.b = asf(45);
		CantHits &= ~atr.frozen;
		array_push(Cond, function(inst2, proj) {
			if (has(inst2.Atrs, atr.moab)) proj.dmg += 1;
			if (proj.distancetraveled >= 150)
			{
				if (has(proj.owner.Upgrades, upg.e3)) proj.dmg += 3;
				else proj.dmgmult *= 2;
			}
		});
	}
	
	if (has(Upgrades, upg.c3))
	{ // Bloontonium Darts
		Damage += 1;
		CantHits &= ~(atr.lead | atr.aqua | atr.crystal | atr.frozen);
		if (has(Upgrades, upg.e3))
		{
			Damage += 1;
		}
		
		CritDartInterval = -1;
		if (has(Upgrades, upg.b3))
		{
			CritDartInterval = 5;
			CritDartDmg = 7;
		}
		if (has(Upgrades, upg.b4))
		{
			SuperCritInterval = 3;
			SuperCritDmg = 18;
			SuperCritPierce = 4;
		}
	}
	if (has(Upgrades, upg.c4))
	{ // Bloontonium Radiator
		Damage += 1;
		// MISSING Bloontonium Charges
		// MISSING Catalyst
		// MISSING Ability
	}
	
	if (has(Upgrades, upg.d3))
	{ // Triple Shot
		Shots = 3;
		DoubleDartShots = 0;
		
		Spread = 40;
		if (has(Upgrades, upg.f3)) Spread = 30;
		if (has(Upgrades, upg.e3)) Spread = 10;
		
		AttackSpeedCalcs.a = asf(45);
		if (has(Upgrades, upg.c2)) AttackSpeedCalcs.a = asf(36);
		if (has(Upgrades, upg.e3)) AttackSpeedCalcs.a = asf(60);
		
		AirburstShots = 3;
		AirburstSpread = 30;
	}
	
	if (has(Upgrades, upg.d4))
	{ // Super Monkey Fan Club
		AttackSpeedCalcs.a = asf(30);
		if (has(Upgrades, upg.c2)) AttackSpeedCalcs.a = asf(27);
		if (has(Upgrades, upg.e3)) AttackSpeedCalcs.a = asf(36);
		// MISSING Ability
	}
	
	if (has(Upgrades, upg.e3))
	{ // Spike-O-Pult
		Damage += 1;
		Pierce += 20;
		CantHits &= ~atr.frozen;
	}
	if (has(Upgrades, upg.e4))
	{ // Juggernaut
		Pierce += 40;
		AttackSpeedCalcs.b = asf(54);
		if (has(Upgrades, upg.a3)) AttackSpeedCalcs.b = asf(51);
		CantHits &= ~atr.lead;
		array_push(Cond, function(inst2, proj) {
			if (has(inst2.Atrs, atr.ceramic)) proj.dmg += 3;
			if (has(inst2.Atrs, atr.fort)) proj.dmg += 2;
		});
		// MISSING Bloontonium Synergy
		// MISSING Bounce
		// MISSING Knockback
		// MISSING CantHit Piercing
		// MISSING Amber Forgiveness
	}
	
	if (has(Upgrades, upg.f3))
	{ // Airburst Darts
		DoubleDartInterval = -1;
		AirburstInterval = 3;
		if (!has(Upgrades, upg.d3)) AttackSpeedCalcs.a = asf(36);
		CantHits &= ~atr.aqua;
		array_push(AfterHit, function(inst2, childs, proj) {
			with (proj)
			{
				if (airburst && instance_exists(owner))
				{
					var shots = owner.AirburstShots;
					var spread = owner.AirburstSpread;
					var spd2 = owner.AirburstVelocity;
					if (crit) spd2 *= 1.25;
					var d = dir;
					for (var i = 0; i < shots; i++)
					{
						instance_create_layer(x, y, "Projectiles", Projectile, {owner : owner, crit : crit, airburst : false, dir : d + spread * (i - (shots - 1) / 2), spd : spd2, lifetime : owner.AirburstTravelDistance / spd2, rad : rad, pierce : owner.Pierce, damage : damage, damagemult : damagemult, cantHits : cantHits, cond : cond, afterHit : afterHit, tick : tick});
					}
				}
			}
			return false;
		});
	}
	if (has(Upgrades, upg.f4))
	{ // Mecha Monkey
		AirburstInterval = 1;
		Damage += 1;
		CantHits &= ~atr.frozen;
		// MISSING Airburst Spawned Darts unaffected by Damage +1
		// MISSING Exploding Dart
	}
	
	calculaterange();
	calculateattackspeed();
}