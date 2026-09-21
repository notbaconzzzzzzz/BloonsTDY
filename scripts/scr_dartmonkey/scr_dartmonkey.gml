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
	CritDartPierce = 0;
	DoubleDartInterval = -1;
	DoubleDartShots = 1;
	AirburstInterval = -1;
	AirburstShots = 2;
	AirburstSpread = 20;
	AirburstPierce = 2;
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
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Razor Sharp Shots",
		price : 220,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Long Range Darts",
		price : 90,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Enhanced Eyesight",
		price : 200,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Crossbow",
		price : 625,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Sharp Shooter",
		price : 5250,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Critical Darts",
		price : 150,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Double Darts",
		price : 240,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Bloontonium Darts",
		price : 550,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Quick Shots",
		price : 100,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Very Quick Shots",
		price : 190,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Triple Shot",
		price : 500,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Super Monkey Fan Club",
		price : 3000,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Spike-O-Pult",
		price : 450,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	},
	{
		name : "Juggernaut",
		price : 2400,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}], [
	{
		name : "Airburst Darts",
		price : 725,
		action : function(inst) { with (inst) { DartMonkey_restats(); }}
	}]] };

	/*
	TowerData = { ups : [[
	{
		name : "Sharp Shots",
		price : 140,
		action : function(inst) { with (inst) {
			Pierce += 1;
		}}
	},
	{
		name : "Razor Sharp Shots",
		price : 220,
		action : function(inst) { with (inst) {
			Pierce += 2;
		}}
	}], [
	{
		name : "Long Range Darts",
		price : 90,
		action : function(inst) { with (inst) {
			Range += 5;
			calculaterange();
		}}
	},
	{
		name : "Enhanced Eyesight",
		price : 200,
		action : function(inst) { with (inst) {
			Range += 5;
			CantHits &= ~atr.camo;
			calculaterange();
		}}
	},
	{
		name : "Crossbow",
		price : 625,
		action : function(inst) { with (inst) {
			Damage += 2;
			Pierce += 1;
			Range += 5;
			Velocity = 24;
			ProjRad = 8;
			if (CritDartDmg < 3) CritDartDmg = 3;
			AttackSpeedCalcs.base = asf(66);
			array_push(Cond, function(inst2, proj) {
				if (has(inst2.Atrs, atr.moab)) proj.dmg += 1;
			});
			if (has(Upgrades, upg.e3))
			{
				Velocity = 20;
				ProjRad = 16;
				AttackSpeedCalcs.base = asf(75);
			}
			calculaterange();
			calculateattackspeed();
		}}
	}], [
	{
		name : "Critical Darts",
		price : 150,
		action : function(inst) { with (inst) {
			CritDartInterval = 4;
			if (CritDartDmg < 1) CritDartDmg = 1;
		}}
	},
	{
		name : "Double Darts",
		price : 240,
		action : function(inst) { with (inst) {
			DoubleDartInterval = 3;
			if (has(Upgrades, upg.d3))
			{
				AttackSpeedCalcs.a = asf(36);
				calculateattackspeed();
			}
		}}
	},
	{
		name : "Bloontonium Darts",
		price : 550,
		action : function(inst) { with (inst) {
			Damage += 1;
			CritDartInterval = -1;
			CantHits &= ~(atr.lead | atr.aqua | atr.crystal | atr.frozen);
			if (has(Upgrades, upg.e3))
			{
				Damage += 1;
			}
			if (has(Upgrades, upg.b3))
			{
				CritDartInterval = 5;
				if (CritDartDmg < 7) CritDartDmg = 7;
			}
		}}
	}], [
	{
		name : "Quick Shots",
		price : 100,
		action : function(inst) { with (inst) {
			AttackSpeedCalcs.a = asf(51);
			calculateattackspeed();
		}}
	},
	{
		name : "Very Quick Shots",
		price : 190,
		action : function(inst) { with (inst) {
			AttackSpeedCalcs.a = asf(40);
			calculateattackspeed();
		}}
	},
	{
		name : "Triple Shot",
		price : 500,
		action : function(inst) { with (inst) {
			Shots = 3;
			DoubleDartShots = 0;
			if (has(Upgrades, upg.e3)) AttackSpeedCalcs.a = asf(60);
			else if (has(Upgrades, upg.c2)) AttackSpeedCalcs.a = asf(36);
			else AttackSpeedCalcs.a = asf(45);
			calculateattackspeed();
		}}
	}], [
	{
		name : "Spike-O-Pult",
		price : 450,
		action : function(inst) { with (inst) {
			Damage += 1;
			Pierce += 20;
			TravelRatio = 36;
			Velocity = 15;
			ProjRad = 20;
			AttackSpeedCalcs.base = asf(75);
			if (has(Upgrades, upg.d3)) AttackSpeedCalcs.a = asf(60);
			CantHits &= ~atr.frozen;
			if (has(Upgrades, upg.c3))
			{
				Damage += 1;
			}
			if (has(Upgrades, upg.b3))
			{
				Velocity = 20;
				ProjRad = 16;
			}
			if (Spread > 10) Spread = 10;
			calculaterange();
			calculateattackspeed();
		}}
	}], []] };*/
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
			CritDartInterval = 12;
			CritDartDmg = 8;
			CritDartPierce = 2;
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
			CritDartInterval = 15;
			CritDartDmg = 25;
			CritDartPierce = 4;
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
	
	if (has(Upgrades, upg.d3))
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
						instance_create_layer(x, y, "Projectiles", Projectile, {owner : owner, crit : crit, airburst : false, dir : d + spread * (i - (shots - 1) / 2), spd : spd2, lifetime : owner.AirburstTravelDistance / spd2, rad : rad, pierce : owner.AirburstPierce, damage : damage, damagemult : damagemult, cantHits : cantHits, cond : cond, afterHit : afterHit, tick : tick});
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