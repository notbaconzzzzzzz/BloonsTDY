/// @description Insert description here
// You can write your code in this editor
if (keyboard_check(vk_shift))
{
	if (grid < 5) grid = 5;
	else if (grid < 10) grid = 10;
	else if (grid < 30) grid = 30;
	else if (grid < 60) grid = 60;
	else grid = 1;
}
else
{
	if (grid == 1) grid = 60;
	else if (grid > 30) grid = 30;
	else if (grid > 10) grid = 10;
	else if (grid > 5) grid = 5;
	else grid = 1;
}