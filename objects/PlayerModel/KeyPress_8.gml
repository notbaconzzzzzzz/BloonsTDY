/// @description Insert description here
// You can write your code in this editor
if (selectedTower != noone)
{
	instance_destroy(selectedTower);
	if (selectedTower == quickUpgradeTower) quickUpgradeTower = noone;
	if (selectedTower == hoveredTower) hoveredTower = noone;
	selectedTower = noone;
}
else if (quickUpgradeTower != noone)
{
	instance_destroy(quickUpgradeTower);
	if (quickUpgradeTower == selectedTower) selectedTower = noone;
	if (quickUpgradeTower == hoveredTower) hoveredTower = noone;
	quickUpgradeTower = noone;
}
else if (hoveredTower != noone)
{
	instance_destroy(hoveredTower);
	if (hoveredTower == selectedTower) selectedTower = noone;
	if (hoveredTower == quickUpgradeTower) quickUpgradeTower = noone;
	hoveredTower = noone;
}