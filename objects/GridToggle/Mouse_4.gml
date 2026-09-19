
if (MenuManager.currentMenu != "none") return;
if (keyboard_check(vk_shift))
{
	if (PlayerModel.grid < 5) PlayerModel.grid = 5;
	else if (PlayerModel.grid < 10) PlayerModel.grid = 10;
	else if (PlayerModel.grid < 30) PlayerModel.grid = 30;
	else if (PlayerModel.grid < 60) PlayerModel.grid = 60;
	else PlayerModel.grid = 1;
}
else
{
	if (PlayerModel.grid == 1) PlayerModel.grid = 60;
	else if (PlayerModel.grid > 30) PlayerModel.grid = 30;
	else if (PlayerModel.grid > 10) PlayerModel.grid = 10;
	else if (PlayerModel.grid > 5) PlayerModel.grid = 5;
	else PlayerModel.grid = 1;
}
value = PlayerModel.grid;