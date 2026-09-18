if (debug)
{
	var type = "bob";
	var mods = atr.none;
	if (keyboard_check(vk_control)) type = "bteab";
	if (keyboard_check(vk_alt)) type += "mega";
	if (keyboard_check(vk_shift))
	{
		mods |= atr.fort;
		mods |= atr.stream;
		if (type != "bteab")
		{
			mods |= atr.regrow;
			mods |= atr.latex;
			mods |= atr.camo;
		}
	}
	spawnbloon(type, mods);
	/*
	for (var i = 0; i < 45; i++)
	{
		if (has(DataManager.BloonData[i].atrs, atr.ceramic)) spawnbloon(i);
	}
	spawnbloon("crystal");*/
}