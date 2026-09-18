/// @description Insert description here
// You can write your code in this editor
if (selectedTower != noone)
{
	instance_destroy(selectedTower);
	selectedTower = noone;
}
else if (quickUpgradeTower != noone)
{
	instance_destroy(quickUpgradeTower);
	quickUpgradeTower = noone;
}
else if (hoveredTower != noone)
{
	instance_destroy(hoveredTower);
	hoveredTower = noone;
}