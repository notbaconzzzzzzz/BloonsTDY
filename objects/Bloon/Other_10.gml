/// @description Insert description here
// You can write your code in this editor
if (hp <= 0)
{
	bloonsplit();
	return;
}
if (has(Atrs, atr.regrow))
{
	if (highestRegrow != typeIndex || (highestRegrow == -1 && hp < MaxHp))
	{
		regenTimer += 1;
		if (regenTimer >= 180)
		{
			if (highestRegrow == -1)
			{
				hp += 5 * power(3, is_struct(BloonData.moab) ? BloonData.moab.class : 0);
				if (hp > MaxHp) hp = MaxHp;
			}
			else
			{
				
			}
			regenTimer -= 180;
		}
	}
	else
	{
		regenTimer = 0;
	}
}