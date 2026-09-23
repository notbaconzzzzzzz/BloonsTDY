/// @description Insert description here
// You can write your code in this editor
if (!variable_instance_exists(id, "destroyoncanthit")) destroyoncanthit = true;
event_inherited();
if (!variable_instance_exists(id, "lifetime")) lifetime = 999999;
xv = spd * dcos(dir);
yv = spd * dsin(dir);
distancetraveled = 0;