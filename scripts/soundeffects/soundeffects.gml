enum blnsnd
{
	dmg,
	dmghard,
	dmgceram,
	dmgamber,
	dmgmoab,
	pop,
	popceram,
	popaqua,
	poptough,
	popamber,
	popglass,
	popmoab0,
	popmoab1,
	popmoab2,
	popmoab3,
	popmoab4,
	hitlead,
	hitaqua,
	hitcrystal,
	hitfrozen,
	hitzebra,
	hitpurple,
	hitclay,
	hittitan,
	hitkant,
	TOTAL_COUNT,
}


function getallassets(name)
{
	var arr = [];
	for (var i = 1; i <= 99; i++)
	{
		var ass = asset_get_index(name + (i < 10 ? "0" + string(i) : string(i)));
		if (ass == -1) break;
		arr[i-1] = ass;
	}
	return arr;
}

function playbloonsound(snd)
{
	GameManager.bloonSounds[snd]++;
}

function playdmgsound(inst)
{
	playbloonsound(getdmgsoundid(inst));
}

function playpopsound(inst)
{
	playbloonsound(getpopsoundid(inst));
}

function playcanthitsound(cants)
{
	playbloonsound(getcanthitsoundid(cants));
}

function getdmgsoundid(inst)
{
	if (has(inst.Atrs, atr.moab)) return blnsnd.dmgmoab;
	if (has(inst.Atrs, atr.amber)) return blnsnd.dmgamber;
	if (has(inst.Atrs, atr.ceramic)) return blnsnd.dmgceram;
	if (has(inst.Atrs, atr.heavy)) return blnsnd.dmghard;
	return blnsnd.dmg;
}

function getpopsoundid(inst)
{
	if (is_struct(inst.BloonData.moab))
	{
		return blnsnd.popmoab0 + inst.BloonData.moab.class;
	}
	if (has(inst.Atrs, atr.amber)) return blnsnd.popamber;
	if (has(inst.Atrs, atr.aqua)) return blnsnd.popaqua;
	if (has(inst.Atrs, atr.titan) || inst.type == "brick") return blnsnd.poptough;
	if (has(inst.Atrs, atr.ceramic)) return blnsnd.popceram;
	if (hasany(inst.Atrs, atr.crystal | atr.frozen | atr.ice)) return blnsnd.popglass;
	return blnsnd.pop;
}

function getcanthitsoundid(cants)
{
	if (has(cants, atr.crystal)) return blnsnd.hitcrystal;
	if (has(cants, atr.aqua)) return blnsnd.hitaqua;
	if (has(cants, atr.lead)) return blnsnd.hitlead;
	if (hasany(cants, atr.frozen | atr.ice)) return blnsnd.hitfrozen;
	if (has(cants, atr.purple)) return blnsnd.hitpurple;
	if (hasany(cants, atr.black | atr.white)) return blnsnd.hitzebra;
	return blnsnd.hitzebra;
}