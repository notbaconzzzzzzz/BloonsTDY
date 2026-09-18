/// @description Insert description here
// You can write your code in this editor
if (GameManager.debug)
{
	var amt = 100; // 100
	if (keyboard_check(vk_shift)) amt *= 10; // 1,000
	if (keyboard_check(vk_control)) amt *= 100; // 10,000
	if (keyboard_check(vk_alt)) amt *= 10000; // 1,000,000
	money += amt; // 100,000 was the previous amount
}