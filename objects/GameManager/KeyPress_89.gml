if (debug)
{
	//spawnbloon("moab");
	
	
	var type = "bob";
	var mods = atr.none;
	if (keyboard_check(vk_control)) type = "bteab";
	if (keyboard_check(vk_alt)) { type += "mega"; clusterMode = max(1, clusterMode); }
	if (keyboard_check(vk_shift))
	{
		mods |= atr.fort;
		mods |= atr.stream;
		mods |= atr.hive;
		if (type != "bteab")
		{
			mods |= atr.regrow;
			mods |= atr.latex;
			mods |= atr.camo;
		}
	}
	spawnbloon(type, mods);
	/*
	for (var i = 0; i < array_length(DataManager.BloonData); i++)
	{
		if (has(DataManager.BloonData[i].atrs, atr.honey))
		{
			spawnbloon(i, atr.hive);
		}
	}*/
}
ticksPasted = 0;