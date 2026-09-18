/// @description Insert description here
// You can write your code in this editor
event_inherited();
if (!variable_instance_exists(id, "path"))
{
	path = juncchoosepath(TrackManager.StartingJunc);
	patht = -60-rad;
}
if (!variable_instance_exists(id, "patht"))
{
	patht = 0;
}
if (hp > 0)
{
	pathmovement(0);
	xv = 0;
	yv = 0;
}