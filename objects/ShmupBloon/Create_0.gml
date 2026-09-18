/// @description Insert description here
// You can write your code in this editor
event_inherited();
if (!variable_instance_exists(id, "dir")) dir = random_range(0, 360);
var spd = Spd / 60;
xv = spd * dcos(dir);
yv = spd * dsin(dir);
finishdist = room_height - y;