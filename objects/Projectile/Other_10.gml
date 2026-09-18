/// @description Insert description here
// You can write your code in this editor
lifetime -= 1;
if (lifetime < 0)
{
	instance_destroy();
	return;
}
x += xv;
y += yv;
distancetraveled += spd;
if (x < 0 || x > room_width || y < 0 || y > room_height)
{
	instance_destroy();
	return;
}
event_inherited();
if (pierce <= 0) instance_destroy();