// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum atr
{
	none = int64(0),
	hard = int64(1) << 0,
	hardy = int64(1) << 1,
	heavy = int64(1) << 2,
	ceramic = int64(1) << 3,
	moab = int64(1) << 4,
	titan = int64(1) << 5,
	amber = int64(1) << 6,
	ice = int64(1) << 7,
	indigo = int64(1) << 8,
	hex = int64(1) << 9,
	hah = int64(1) << 10,
	kant = int64(1) << 11,
	bob = int64(1) << 12,
	tide = int64(1) << 13,
	honey = int64(1) << 14,
	black = int64(1) << 15,
	white = int64(1) << 16,
	purple = int64(1) << 17,
	lead = int64(1) << 18,
	aqua = int64(1) << 19,
	crystal = int64(1) << 20,
	frozen = int64(1) << 21,
	clay = int64(1) << 22,
	camo = int64(1) << 23,
	regrow = int64(1) << 24,
	stream = int64(1) << 25,
	fort = int64(1) << 26,
	latex = int64(1) << 27,
	ostuffed = int64(1) << 28,
	ustuffed = int64(1) << 29,
	hive = int64(1) << 30,
	mega = int64(1) << 31,
	canthits = atr.lead | atr.aqua | atr.crystal | atr.frozen | atr.camo,
	canfort = atr.hardy | atr.heavy | atr.ceramic | atr.moab,
	canhive = atr.moab | atr.honey,
	inherit = atr.camo | atr.regrow | atr.stream | atr.latex | atr.ostuffed | atr.ustuffed,
	allinherit = atr.camo | atr.regrow | atr.stream | atr.fort | atr.latex | atr.ostuffed | atr.ustuffed | atr.hive,
	spriteindexed = ((int64(1) << 32) - (int64(1) << 2)) - atr.stream - atr.latex,
}

enum upg
{
	none = int64(0),
	a1 = int64(1) << 0,
	b1 = int64(1) << 1,
	c1 = int64(1) << 2,
	d1 = int64(1) << 3,
	a2 = int64(1) << 4,
	b2 = int64(1) << 5,
	c2 = int64(1) << 6,
	d2 = int64(1) << 7,
	a3 = int64(1) << 8,
	b3 = int64(1) << 9,
	c3 = int64(1) << 10,
	d3 = int64(1) << 11,
	e3 = int64(1) << 12,
	f3 = int64(1) << 13,
	a4 = int64(1) << 14,
	b4 = int64(1) << 15,
	c4 = int64(1) << 16,
	d4 = int64(1) << 17,
	e4 = int64(1) << 18,
	f4 = int64(1) << 19,
	T1 = upg.a1 | upg.b1 | upg.c1 | upg.d1,
	T2 = upg.a2 | upg.b2 | upg.c2 | upg.d2,
	T3 = upg.a3 | upg.b3 | upg.c3 | upg.d3 | upg.e3 | upg.f3,
	T4 = upg.a4 | upg.b4 | upg.c4 | upg.d4 | upg.e4 | upg.f4,
	T12 = upg.T1 | upg.T2,
	T34 = upg.T3 | upg.T4,
	A = upg.a1 | upg.a2 | upg.a3 | upg.a4,
	B = upg.b1 | upg.b2 | upg.b3 | upg.b4,
	C = upg.c1 | upg.c2 | upg.c3 | upg.c4,
	D = upg.d1 | upg.d2 | upg.d3 | upg.d4,
	E = upg.e3 | upg.e4,
	F = upg.f3 | upg.f4,
}

function has(arr, val)
{
	return arr & val == val;
}

function hasany(arr, val)
{
	return arr & val != int64(0);
}

function getatrfromstring(str)
{
	switch (str)
	{
		case "hard": return atr.hard;
		case "hardy": return atr.hardy;
		case "heavy": return atr.heavy;
		case "ceramic": return atr.ceramic;
		case "moab": return atr.moab;
		case "titan": return atr.titan;
		case "amber": return atr.amber;
		case "ice": return atr.ice;
		case "indigo": return atr.indigo;
		case "hex": return atr.hex;
		case "hah": return atr.hah;
		case "kant": return atr.kant;
		case "bob": return atr.bob;
		case "tide": return atr.tide;
		case "honey": return atr.honey;
		case "black": return atr.black;
		case "white": return atr.white;
		case "purple": return atr.purple;
		case "lead": return atr.lead;
		case "aqua": return atr.aqua;
		case "crystal": return atr.crystal;
		case "frozen": return atr.frozen;
		case "clay": return atr.clay;
		case "camo": return atr.camo;
		case "regrow": return atr.regrow;
		case "stream": return atr.stream;
		case "fort": return atr.fort;
		case "latex": return atr.latex;
		case "ostuffed": return atr.ostuffed;
		case "ustuffed": return atr.ustuffed;
		case "hive": return atr.hive;
		case "mega": return atr.mega;
	}
	return atr.none;
}

function getatrfromletter(str)
{
	switch (str)
	{
		case "c": return atr.camo;
		case "r": return atr.regrow;
		case "s": return atr.stream;
		case "f": return atr.fort;
		case "l": return atr.latex;
		case "o": return atr.ostuffed;
		case "u": return atr.ustuffed;
		case "h": return atr.hive;
	}
	return atr.none;
}

function getupgfromindex(path, tier)
{
	switch (path)
	{
		case 1: switch (tier) {
				case 1: return upg.a1;
				case 2: return upg.a2;
				case 3: return upg.a3;
				case 4: return upg.a4; } return upg.none;
		case 2: switch (tier) {
				case 1: return upg.b1;
				case 2: return upg.b2;
				case 3: return upg.b3;
				case 4: return upg.b4; } return upg.none;
		case 3: switch (tier) {
				case 1: return upg.c1;
				case 2: return upg.c2;
				case 3: return upg.c3;
				case 4: return upg.c4; } return upg.none;
		case 4: switch (tier) {
				case 1: return upg.d1;
				case 2: return upg.d2;
				case 3: return upg.d3;
				case 4: return upg.d4; } return upg.none;
		case 5: switch (tier) {
				case 3: return upg.e3;
				case 4: return upg.e4; } return upg.none;
		case 6: switch (tier) {
				case 3: return upg.f3;
				case 4: return upg.f4; } return upg.none;
	}
	return upg.none;
}