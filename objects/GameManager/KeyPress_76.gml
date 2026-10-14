if (debug)
{
	var num = 1;
	if (keyboard_check(vk_shift)) num *= 10;
	if (keyboard_check(vk_control)) num *= 100;
	if (keyboard_check(vk_alt))
	{
		for (var i = 0; i < num; i++) spawnbloon("amber");
	}
	else
	{
		spawnblooncluster("amber", num);
	}
}