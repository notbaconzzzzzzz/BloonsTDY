/// @description Insert description here
// You can write your code in this editor
surf = surface_create(800, 800);
surf2 = surface_create(800, 800);
bloonInd = -5;
mods = [];
wait = 0;
Sizes = [49, 52, 55, 58, 61, 37, 37, 58];
colors = [
[make_color_hsv(0/360*255, 212, 234), make_color_hsv(0/360*255, 212, 234/2)],
[make_color_hsv(210/360*255, 212, 234), make_color_hsv(210/360*255, 212, 234/2)],
[make_color_hsv(80/360*255, 232, 162), make_color_hsv(80/360*255, 232, 162/2)],
[make_color_hsv(50/360*255, 255, 255), make_color_hsv(50/360*255, 255, 255/2)],
[make_color_hsv(355/360*255, 180, 255), make_color_hsv(355/360*255, 180, 255/2)],
[make_color_hsv(0/360*255, 0, 32), make_color_hsv(0/360*255, 0, 32/2)],
[make_color_hsv(0/360*255, 0, 212), make_color_hsv(0/360*255, 0, 212/2)],
[make_color_hsv(275/360*255, 220, 224), make_color_hsv(195/360*255, 204, 255), make_color_hsv(275/360*255, 220, 224/2)]
];
drawQueue = [];
for (var i = 0; i < array_length(DataManager.BloonData); i++)
{
	var atrs = DataManager.BloonData[i].atrs;
	array_push(drawQueue, calculatespriteindex(i, DataManager.BloonData[i].atrs));
}
spawned = false;
BloonSprites = ds_map_create();
wait = 5;