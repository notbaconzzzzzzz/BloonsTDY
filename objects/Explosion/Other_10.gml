/// @description Insert description here
// You can write your code in this editor
rad += vel;
if (vel > 12) vel -= 2;
else if (vel > 0) vel -= 1;
else { instance_destroy(); return; }
event_inherited();