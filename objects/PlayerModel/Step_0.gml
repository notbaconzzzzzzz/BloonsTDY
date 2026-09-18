/// @description Insert description here
// You can write your code in this editor
if (MenuManager.currentMenu != "none")
{
	hoveredTower = noone;
	tryingtobuytower = false;
	showRanges = false;
	return;
}
var autobuythreshold = 200;
if (autobuyupgrade)
{
	autobuythreshold = max(autobuythreshold, 100 + numberoftowers * 50);
}
if (autobuytower && money >= autobuythreshold)
{
	purchasetower(-999, -999);
}
if (tryingtobuytower)
{
	var tx = mouse_x;
	var ty = mouse_y;
	tx = round(tx / grid) * grid;
	ty = round(ty / grid) * grid;
	tryingtobuytowertx = tx;
	tryingtobuytowerty = ty;
	tryingtobuytowervalidposition = isvalidtowerposition(tx, ty);
	if (money < 200) tryingtobuytowervalidposition = false;
}