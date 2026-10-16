/// @description Insert description here
// You can write your code in this editor
if (MenuManager.currentMenu != "none")
{
	hoveredTower = noone;
	tryingtobuytower = false;
	showRanges = false;
	return;
}
if (autobuytower)
{
	var autobuythreshold = getupgradeprice(0, 0).price;
	if (autobuyupgrade)
	{
		autobuythreshold = max(autobuythreshold, 100 + numberoftowers * 100);
	}
	if (money >= autobuythreshold)
	{
		purchasetower(-999, -999);
	}
}
if (tryingtobuytower)
{
	tryingtobuytowerdetectionrange = 20*9;
	tryingtobuytowerradius = 30;
	tryingtobuytowercolor = make_color_rgb(192, 128, 32);
	tryingtobuytowerprice = getupgradeprice(0, 0);
	var tx = mouse_x;
	var ty = mouse_y;
	tx = round(tx / grid) * grid;
	ty = round(ty / grid) * grid;
	tryingtobuytowertx = tx;
	tryingtobuytowerty = ty;
	tryingtobuytowervalidposition = isvalidtowerposition(tx, ty);
	tryingtobuytowercanafford = money >= tryingtobuytowerprice.price;
}