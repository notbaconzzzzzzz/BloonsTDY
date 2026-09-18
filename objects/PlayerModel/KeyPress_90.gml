/// @description Insert description here
// You can write your code in this editor
if (keyboard_check(vk_alt))
{
	autobuytower = !autobuytower;
}
else if (keyboard_check(vk_control))
{
	purchasetower(-999, -999);
}
else if (tryingtobuytower)
{
	tryingtobuytower = false;
	showRanges = false;
}
else
{
	tryingtobuytower = true;
	showRanges = true;
	selectedTower = noone;
	quickUpgradeTower = noone;
}