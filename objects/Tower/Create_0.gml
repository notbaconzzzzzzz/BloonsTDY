/// @description Insert description here
// You can write your code in this editor
calculaterange();
calculateattackspeed();
attackDelay = 0;

Upgrades = upg.none;
TotalT12 = 0;
TotalT3 = 0;
TotalT4 = 0;
LowestT12 = 999999;
HighestT12 = 0;
LowestT3 = 999999;
SumT4 = 0;
NextRandUp = irandom_range(1, 4);
PossibleUpgrades = [];
for (var i = 0; i <= 20; i++)
{
	PossibleUpgrades[i] = isupgradepossible(getindexupgpath(i), getindexupgtier(i));
}