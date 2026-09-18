/// @description Insert description here
// You can write your code in this editor
if (MenuManager.currentMenu != "none")
{
	return;
}
if (PlayerModel.hoveredTower == id)
{
	if (point_distance(x, y, mouse_x, mouse_y) > 140) PlayerModel.hoveredTower = noone;
}
else if (PlayerModel.hoveredTower == noone)
{
	if (point_distance(x, y, mouse_x, mouse_y) <= 100) PlayerModel.hoveredTower = id;
}
else
{
	if (point_distance(x, y, mouse_x, mouse_y) < min(100, point_distance(PlayerModel.hoveredTower.x, PlayerModel.hoveredTower.y, mouse_x, mouse_y))) PlayerModel.hoveredTower = id;
}
if (PlayerModel.quickUpgradeTower == id)
{
	var path5 = isupgradevalid(5) == 1;
	var path6 = isupgradevalid(6) == 1;
	if (point_distance(x, y, mouse_x, mouse_y) <= 30) PlayerModel.hoverQuadrant = 0;
	else if (abs(mouse_x - x) > 100 || abs(mouse_y - y) > 100) PlayerModel.hoverQuadrant = 0;
	else if (mouse_x < x) {
		if (path5)
		{
			if (mouse_y <= y - 33) PlayerModel.hoverQuadrant = 1;
			else if (mouse_y >= y + 33) PlayerModel.hoverQuadrant = 2;
			else PlayerModel.hoverQuadrant = 5;
		}
		else if (mouse_y < y) PlayerModel.hoverQuadrant = 1;
		else PlayerModel.hoverQuadrant = 2;
	} else {
		if (path6)
		{
			if (mouse_y <= y - 33) PlayerModel.hoverQuadrant = 3;
			else if (mouse_y >= y + 33) PlayerModel.hoverQuadrant = 4;
			else PlayerModel.hoverQuadrant = 6;
		}
		else if (mouse_y < y) PlayerModel.hoverQuadrant = 3;
		else PlayerModel.hoverQuadrant = 4;
	}
}
if (NextRandUp != -1 && PlayerModel.autobuyupgrade)
{
	var result = purchaseupgrade(NextRandUp);
	if (result == 1 || result == -1)
	{
		var temp = [];
		for (var i = 0; i < 6; i++)
		{
			if (isupgradevalid(i) == 1) array_push(temp, i);
		}
		if (array_length(temp) <= 0) NextRandUp = -1;
		else NextRandUp = temp[irandom_range(0, array_length(temp) - 1)];
	}
}