/// @description Insert description here
// You can write your code in this editor
for (var i = 0; i <= 12; i++)
{
	bloonRegions[i].Clear(); 
}
with (ProjBase) instance_destroy();
with (Bloon) instance_destroy();
with (Tower) instance_destroy();
resetround();
gameSpeed = 0;