/// @description Insert description here
// You can write your code in this editor
if (tryingtobuytower)
{
	tryingtobuytower = false;
	showRanges = false;
}
else if (hoveredTower != noone)
{
	quickUpgradeTower = hoveredTower;
}
else
{
	quickUpgradeTower = noone;
	selectedTower = noone;
}