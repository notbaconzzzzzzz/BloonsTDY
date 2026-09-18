/// @description Insert description here
// You can write your code in this editor
/*
if (spawned) return;
if (!spawned && bloonInd >= array_length(DataManager.BloonData))
{
	/*
	var cat = 0;
	var cot = -1;
	var kin = [12, 13, 5, 8, 2, 5];
	for (var i = 0; i < array_length(DataManager.BloonData); i++)
	{
		cot++;
		var a = kin[cat];
		var b = cot;
		if (b >= a)
		{
			cat++;
			cot = 0;
			b = cot;
			a = kin[cat];
		}
		var c = cat;
		instance_create_layer(room_width/2 - (a-1)*100/2 + 100*b, 100 + 100*c, "Instances", TestBloon).sprite_index = BloonSprites[i];
	}
	*//*
	spawned = true;
}
wait++;
if (wait >= (spawned ? 60 : 0))
{
	wait = 0;
	bloonInd++;
	if (bloonInd >= array_length(DataManager.BloonData) + 1) bloonInd = 0;
	if (bloonInd >= array_length(DataManager.BloonData) || bloonInd < 0) return;
	var bloonData = DataManager.BloonData[bloonInd];
	mods = bloonData.atrs;
	if (spawned)
	{
		if (random(100) < 25)
		{
			mods |= atr.black;
		}
		if (random(100) < 25)
		{
			mods |= atr.white;
		}
		if (random(100) < 25)
		{
			mods |= atr.purple;
		}
	}
}*/