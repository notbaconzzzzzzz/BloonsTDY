/// @description Insert description here
// You can write your code in this editor
if (typeIndex == -1) return;
event_inherited();
pathmovement(Spd / 60);
if (path == -1)
{
	PlayerModel.lifes -= BloonData.dmg;
	instance_destroy();
	hp = 0;
	typeIndex = -1;
	return;
}
var newBloonRegion = calculatebloonregion(x, y, IsMoab);
if (newBloonRegion != bloonRegion)
{
	bloonRegion = newBloonRegion;
	bloonRegionNode.Migrate(GameManager.bloonRegions[bloonRegion]);
}