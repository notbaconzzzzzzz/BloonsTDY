/// @description Insert description here
// You can write your code in this editor
event_inherited();
if (typeIndex == -1) return;
if (!variable_instance_exists(id, "path"))
{
	path = juncchoosepath(TrackManager.StartingJunc);
	patht = -60-rad;
}
if (!variable_instance_exists(id, "patht"))
{
	patht = 0;
}
if (variable_instance_exists(id, "blowtime") && blowtime > 0)
{
	var px = x;
	var py = y;
	pathmovement(0);
	var pos = getposfrompath(path, patht);
	if (!variable_instance_exists(id, "blowt"))
	{
		blowt = 0;
		blowx0 = px;
		blowy0 = py;
		//pathmovement(Spd * blowtime / 60);
		blowx2 = pos.x;
		blowy2 = pos.y - posoffset;
	}
	else
	{
		var dx = pos.x - blowx2;
		var dy = pos.y - blowy2;
		blowx0 += dx;
		blowy0 += dy;
		blowx1 += dx;
		blowy1 += dy;
		blowx2 += dx;
		blowy2 += dy;
		blowy2 -= posoffset;
	}
	var t = blowt / blowtime;
	x = bezier(blowx0, blowx1, blowx1, blowx2, t);
	y = bezier(blowy0, blowy1, blowy1, blowy2, t);
	xv = 0;
	yv = 0;
	dir = pos.dir;
	finishdist = pos.finishdist;
}
else if (hp > 0)
{
	pathmovement(0);
	xv = 0;
	yv = 0;
}