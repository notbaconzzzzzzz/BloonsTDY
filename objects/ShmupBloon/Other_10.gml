/// @description Insert description here
// You can write your code in this editor
event_inherited();
if (typeIndex == -1) return;
x += xv;
y += yv;
if (x <= GameManager.shmupLeftBound + rad)
{
	xv = abs(xv);
	dir = darctan2(yv, xv);
}
if (x >= GameManager.shmupRightBound - rad)
{
	xv = -abs(xv);
	dir = darctan2(yv, xv);
}
if (y <= rad)
{
	yv = abs(yv);
	dir = darctan2(yv, xv);
}
finishdist = room_height - y;
/*
if (y >= room_height - rad)
{
	yv = -abs(yv);
	dir = darctan2(yv, xv);
}*/
if (y >= room_height + rad)
{
	PlayerModel.lifes -= BloonData.dmg;
	instance_destroy();
	hp = 0;
	typeIndex = -1;
	return;
}
if (bloonRegionNode != -1 && !is_undefined(bloonRegionNode))
{
	var newBloonRegion = calculatebloonregion(x, y, IsMoab);
	if (newBloonRegion != bloonRegion)
	{
		bloonRegion = newBloonRegion;
		bloonRegionNode.Migrate(GameManager.bloonRegions[bloonRegion]);
	}
}