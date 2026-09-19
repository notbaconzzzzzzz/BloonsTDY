/// @description Insert description here
// You can write your code in this editor
isCluster = false;
if (!variable_instance_exists(id, "type")) type = "red";
typeIndex = array_get_index(DataManager.BloonOrd, type);
if (typeIndex == -1) typeIndex = 0;
BloonData = DataManager.BloonData[typeIndex];
if (variable_instance_exists(id, "Atrs"))
{
	Atrs |= BloonData.atrs;
}
else
{
	Atrs = BloonData.atrs;
}
if (variable_instance_exists(id, "RemoveAtrs"))
{
	Atrs &= ~RemoveAtrs;
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
if (has(Atrs, atr.regrow))
{
	if (!variable_instance_exists(id, "regenTimer") || highestRegrow == -1)
	{
		regenTimer = 0;
		highestRegrow = typeIndex;
	}
	if (has(Atrs, atr.moab))
	{
		highestRegrow = -1;
	}
}
if (!variable_instance_exists(id, "highestValue") || highestValue > typeIndex)
{
	highestValue = typeIndex;
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

if (variable_instance_exists(id, "hp"))
{
	if (variable_instance_exists(id, "bloonsplitcanthit"))
	{
		if (hasany(Atrs, bloonsplitcanthit))
		{
			hp = 0;
		}
	}
	hp += MaxHp;
}
else hp = MaxHp;
if (!variable_instance_exists(id, "parent")) parent = noone;
if (hp <= 0)
{
	parentInstances = [];
	if (instance_exists(parent)) array_copy(parentInstances, 1, parent.parentInstances, 0, array_length(parent.parentInstances));
	bloonsplit(variable_instance_exists(id, "bloonsplitcanthit") ? bloonsplitcanthit : atr.none, true);
	return;
}
var sprind = calculatespriteindex(typeIndex, Atrs);
var spr = BloonRenderer.BloonSprites[? sprind];
if (is_undefined(spr))
{
	if (!array_contains(BloonRenderer.drawQueue, sprind)) array_push(BloonRenderer.drawQueue, sprind);
}
else sprite_index = spr;
if (has(Atrs, atr.regrow)) rad *= 1.25;
parentInstances = [id];
if (instance_exists(parent)) array_copy(parentInstances, 1, parent.parentInstances, 0, array_length(parent.parentInstances));