/// @description Insert description here
// You can write your code in this editor
/*
var cantHits = atr.black;
var cond = [
function(inst, proj) {
	if (array_contains(inst.BloonData.atr, "ceramic")) proj.dmg += 1;
},
function(inst, proj) {
	if (array_contains(inst.BloonData.atr, "moab")) proj.dmg += 8;
}
];
instance_create_layer(mouse_x, mouse_y, "Instances", Explosion, {rad : 4, vel : 20, pierce : 22, damage : 2, cantHits : cantHits, cond : cond});
cantHits = atr.lead | atr.aqua | atr.crystal | atr.frozen;
cond = [
function(inst, proj) {
	if (array_contains(inst.BloonData.atr, "moab")) proj.dmg += 2;
}
];
for (var d = 0; d < 360; d += 22.5)
{
	instance_create_layer(mouse_x, mouse_y, "Instances", Projectile, {dir : d, spd : 20, pierce : 5, damage : 1, cantHits : cantHits, cond : cond});
}
*/
if (tryingtobuytower)
{
	var tx = mouse_x;
	var ty = mouse_y;
	tx = round(tx / grid) * grid;
	ty = round(ty / grid) * grid;
	if (purchasetower(tx, ty) > 0)
	{
		if (!keyboard_check(vk_shift))
		{
			tryingtobuytower = false;
			showRanges = false;
		}
	}
}
else if (hoveredTower != noone && hoverQuadrant != 0)
{
	with (hoveredTower)
	{
		purchaseupgrade(PlayerModel.hoverQuadrant);
	}
}