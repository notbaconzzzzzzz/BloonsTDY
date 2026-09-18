/// @description Insert description here
// You can write your code in this editor
pathmovement(Spd / 60);
if (path == -1)
{
	PlayerModel.lifes -= BloonData.dmg;
	instance_destroy();
}
event_inherited();