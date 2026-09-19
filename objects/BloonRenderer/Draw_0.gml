/// @description Insert description here
// You can write your code in this editor
//if (bloonInd >= array_length(DataManager.BloonData) || bloonInd < 0) return;
if (wait > 0) wait--;
if (array_length(drawQueue) <= 0) return;

var sprite = generatebloonsprite(array_pop(drawQueue));

if (!spawned) draw_sprite(sprite, 0, room_width / 2, room_height / 2);

if (array_length(drawQueue) <= 0) spawned = true;

//surface_save_part(surf, "Test.png", 350, 350, 100, 100);