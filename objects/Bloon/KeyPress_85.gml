/// @description Insert description here
// You can write your code in this editor
if (GameManager.debug)
{
	if (isCluster)
	{
		
	}
	else
	{
		if (keyboard_check(vk_shift)) hp -= ceil(MaxHp / 5);
		else hp = 0;
	}
}