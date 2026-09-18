/// @description Insert description here
// You can write your code in this editor
if (gameSpeed != 0 && keyboard_check(vk_control)) gameSpeed = 0;
else if (keyboard_check(vk_shift)) gameSpeed += 1;
else if (gameSpeed == 1) gameSpeed = 2;
else gameSpeed = 1;