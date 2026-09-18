/// @description Insert description here
// You can write your code in this editor
if (NextRandUp == -1) NextRandUp = irandom_range(1, 4);
var result = purchaseupgrade(NextRandUp);
if (result == 1 || result == -1)
{
	var temp = [];
	for (var i = 0; i < 6; i++)
	{
		if (isupgradevalid(i) == 1) array_push(temp, i);
	}
	if (array_length(temp) <= 0) NextRandUp = -1;
	else NextRandUp = temp[irandom_range(0, array_length(temp) - 1)];
}