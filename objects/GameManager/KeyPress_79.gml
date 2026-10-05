/// @description Insert description here
// You can write your code in this editor
if (debug)
{
	for (var i = 0; i < array_length(DataManager.BloonData); i++)
	{
		if ((i == 38 || i == 39) && !keyboard_check(vk_shift)) continue;
		if ((i >= 40 && i <= 44) && !HoneyBloons) continue;
		if ((i == 45) && !HarbingerBloon) continue;
		spawnbloon(i);
	}
}