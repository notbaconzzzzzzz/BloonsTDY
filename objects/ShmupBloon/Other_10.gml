/// @description Insert description here
// You can write your code in this editor
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
}
event_inherited();