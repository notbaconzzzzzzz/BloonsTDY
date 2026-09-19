// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function calculaterange()
{
	detectionrange = Range * 9;
	traveldistance = Range * TravelRatio;
}

function calculateattackspeed()
{
	var per = AttackSpeedCalcs.base.per;
	var labels = variable_struct_get_names(AttackSpeedCalcs);
	var num;
	if (per)
	{
		num = 3600;
	}
	else
	{
		num = 60;
	}
	for (var i = 0; i < array_length(labels); i++)
	{
		var item = variable_struct_get(AttackSpeedCalcs, labels[i]);
		var per2 = item.per;
		if (per2 == 2) per2 = per;
		if (per) {
			if (per2) {
				num *= item.valper;
				num /= 3600;
			} else {
				num *= 60;
				num /= item.val;
			}
		} else {
			if (per2) {
				num *= 3600;
				num /= item.valper;
			} else {
				num *= item.val;
				num /= 60;
			}
		}
	}
	num = round(num);
	if (per) AttackSpeed = { per : 1, valper : num };
	else AttackSpeed = { per : 0, val : num };
}

function asf(num)
{ // attack speed frames
	return { per : 0, val : num };
}

function aspm(numper)
{ // attack speed per minute
	return { per : 1, valper : num };
}

function asbth(num, numper)
{ // attack speed in both formats used for bufs
	return { per : 2, val : num, valper : numper };
}