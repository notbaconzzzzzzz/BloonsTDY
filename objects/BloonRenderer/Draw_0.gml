/// @description Insert description here
// You can write your code in this editor
//if (bloonInd >= array_length(DataManager.BloonData) || bloonInd < 0) return;
if (wait > 0) wait--;
if (array_length(drawQueue) <= 0) return;

generatebloonsprite(array_pop(drawQueue));

draw_surface(surf2, room_width / 2 - 400, room_height / 2 - 400);
gpu_set_blendmode(bm_normal);

if (array_length(drawQueue) <= 0) spawned = true;

//surface_save_part(surf, "Test.png", 350, 350, 100, 100);