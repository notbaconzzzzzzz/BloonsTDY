// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function datafileread()
{
	currentOpenFile = file_text_open_read(working_directory + "BloonData.txt");
	currentInd = 0;
	word = "";
	prevWord = "";
	if (currentOpenFile != -1)
	{
		currentSentence = file_text_readln(currentOpenFile);
		currentSentenceLength = string_length(currentSentence);
		BloonData = [];
		BloonOrd = [];
		discriminantMode = true;
		lineMode = true;
		parsebloondata();
		file_text_close(currentOpenFile);
		currentOpenFile = -1;
	}
	currentOpenFile = file_text_open_read(working_directory + "WaveData.txt");
	currentInd = 0;
	word = "";
	prevWord = "";
	if (currentOpenFile != -1)
	{
		currentSentence = file_text_readln(currentOpenFile);
		currentSentenceLength = string_length(currentSentence);
		WaveData = [[{type : "red", mods : atr.none, removemods : atr.none, amount : 1, spacing : 30, offset : 0}]];
		discriminantMode = false;
		lineMode = false;
		parsewavedata();
		file_text_close(currentOpenFile);
		currentOpenFile = -1;
	}
}

function isletter(char)
{
	if (string_length(char) > 1) char = string_char_at(char, 1);
	if (ord(char) >= ord("a") && ord(char) <= ord("z")) return true;
	return ord(char) >= ord("A") && ord(char) <= ord("Z");
}

function isnumber(char)
{
	if (string_length(char) > 1) char = string_char_at(char, 1);
	return ord(char) >= ord("0") && ord(char) <= ord("9");
}

function nextword()
{
	var whiteSpace = [" ", "\n", "\r", "\t", "\f", "\v"];
	var specialChar = ["{", "}", ";"];
	if (discriminantMode)
	{
		specialChar = ["{", "}", ";", "[", "]", "(", ")", "<", ">", ",", "*", "!"];
	}
	//var specialChar = ["/", "*", "&", "%", "+", "-", "=", "_", "|", ":", "'", "^", ">", "<"];
	//var specialLetter = ["x", "s", "f"];
	while (true)
	{
		if (currentInd >= currentSentenceLength)
		{
			if (file_text_eof(currentOpenFile)) { word = "\r"; return word; }
			currentSentence = file_text_readln(currentOpenFile);
			currentSentenceLength = string_length(currentSentence);
			currentInd = 0;
			if (currentSentenceLength <= 0)
			{
				return nextword();
			}
			if (lineMode) { word = "\n"; return word; }
		}
		var char = string_char_at(currentSentence, currentInd+1);
		if (!array_contains(whiteSpace, char))
		{
			prevWord = word;
			word = char;
			currentInd++;
			break;
		}
		currentInd++;
	}
	if (array_contains(specialChar, word)) return word;
	while (true)
	{
		if (currentInd >= currentSentenceLength) return word;
		var char = string_char_at(currentSentence, currentInd+1);
		if (array_contains(whiteSpace, char)) return word;
		if (array_contains(specialChar, char)) return word;
		word += char;
		currentInd++;
	}
	return word;
}

function parsebloondata()
{
	var bloonInd = 0;
	while (word != "\r")
	{
		var bloonData = {type : "", ind : bloonInd, spd : 100, hp : 1, dmg : 1, dif : 0, size : 49, moab : 0, atrs : atr.none, spawns : [], colors : []};
		var bloonId = "";
		var dataInd = 0;
		while (true)
		{
			nextword();
			if (word == "\r") break;
			if (word == "\n" || word == ";") break;
			else if (word == "(")
			{
				var mInd = 0;
				while (true)
				{
					nextword();
					if (word == "\r") return;
					else if (word == ")") break;
					switch (mInd++)
					{
						case 0:
							bloonData.size = int64(word); break;
						case 1:
							bloonData.moab = {class : 1, stream : 50, hive : []};
							bloonData.moab.class = int64(word); break;
						case 2:
							bloonData.moab.stream = round(real(word) * 100); break;
						case 3:
							if (word == "[")
							{
								while (true)
								{
									nextword();
									if (word == "\r") return;
									else if (word == "]") break;
									array_push(bloonData.moab.hive, word);
								}
							}
							break;
					}
				}
			}
			else if (word == "{")
			{
				while (true)
				{
					nextword();
					if (word == "\r") return;
					else if (word == "}") break;
					else
					{
						bloonData.atrs |= getatrfromstring(word);
					}
				}
			}
			else if (word == "[")
			{
				while (true)
				{
					nextword();
					if (word == "\r") return;
					else if (word == "]") break;
					else if (word == "!")
					{
						nextword();
						if (isnumber(word))
						{
							bloonData.spawns[array_length(bloonData.spawns)-1].disambig = int64(word);
						}
						continue;
					}
					var a = 1;
					var t = "";
					if (isnumber(word))
					{
						a = int64(word);
						while (nextword() == "*")
						{
							
						}
					}
					t = word;
					array_push(bloonData.spawns, {type : t, amt : a});
					var ind = array_get_index(BloonOrd, t);
					if (ind == -1) ind = array_get_index(BloonOrd, string_delete(t, 1, 1));
					if (ind != -1)
					{
						bloonData.dmg += BloonData[ind].dmg * a;
						bloonData.dif += BloonData[ind].dif * a;
					}
				}
			}
			else if (word == "<")
			{
				var h = 0;
				var s = 255;
				var v = 255;
				var cInd = 0;
				while (true)
				{
					nextword();
					if (word == "\r") return;
					else if (word == ">")
					{
						array_push(bloonData.colors, {h : h, s : s, v : v});
						break;
					}
					else if (word == ",")
					{
						array_push(bloonData.colors, {h : h, s : s, v : v});
						cInd = 0;
					}
					else
					{
						switch (cInd++)
						{
							case 0:
								h = int64(word);
							case 1:
								s = int64(word);
							case 2:
								v = int64(word);
						}
					}
				}
			}
			else if (word == "!")
			{
				bloonData.regrowdisambiguation = array_create(10, -1);
				while (true)
				{
					nextword();
					if (word == "\r") return;
					else if (word == "!") break;
					var a = 1;
					var t = "";
					if (isnumber(word))
					{
						a = int64(word);
						while (nextword() == ">")
						{
							
						}
					}
					t = word;
					bloonData.regrowdisambiguation[a] = t;
				}
				for (var i = 0; i < 10; i++)
				{
					if (bloonData.regrowdisambiguation[i] == -1)
					{
						bloonData.regrowdisambiguation[i] = bloonData.regrowdisambiguation[0];
					}
				}
			}
			else
			{
				switch (dataInd++)
				{
					case 0:
						bloonId = word; bloonData.type = word; break;
					case 1:
						bloonData.spd = round(real(word) * 100); break;
					case 2:
						bloonData.hp = int64(word);
						bloonData.dmg = bloonData.hp;
						if (bloonData.hp > 1) bloonData.atrs |= atr.hard;
						break;
				}
			}
		}
		var atrdif = 1;
		if (has(bloonData.atrs, atr.black)) atrdif += 0.05;
		if (has(bloonData.atrs, atr.white)) atrdif += 0.05;
		if (has(bloonData.atrs, atr.purple)) atrdif += 0.05;
		if (has(bloonData.atrs, atr.clay)) atrdif += 0.05;
		if (has(bloonData.atrs, atr.camo)) atrdif += 0.3;
		if (has(bloonData.atrs, atr.frozen)) atrdif += 0.2;
		if (has(bloonData.atrs, atr.lead)) atrdif += 0.4;
		if (has(bloonData.atrs, atr.aqua)) atrdif += 0.8;
		if (has(bloonData.atrs, atr.crystal)) atrdif += 0.6;
		if (has(bloonData.atrs, atr.titan)) atrdif += 2.5;
		if (has(bloonData.atrs, atr.amber)) atrdif += 2;
		if (has(bloonData.atrs, atr.hex)) atrdif += 0.5;
		if (has(bloonData.atrs, atr.hah)) atrdif += 1.5;
		if (has(bloonData.atrs, atr.kant)) atrdif += 1;
		if (has(bloonData.atrs, atr.regrow)) atrdif += 0; // ?
		if (has(bloonData.atrs, atr.fort)) atrdif *= 2; // ?
		if (has(bloonData.atrs, atr.latex)) atrdif += 0; // ?
		if (has(bloonData.atrs, atr.hive)) atrdif += 0; // ?
		if (has(bloonData.atrs, atr.mega)) atrdif *= 10;
		bloonData.dif += bloonData.hp * (bloonData.spd + 100) * atrdif + 20 * (atrdif - 1) * (bloonData.spd + 200);
		BloonData[bloonInd] = bloonData;
		BloonOrd[bloonInd] = bloonId;
		bloonInd++;
	}
	for (var i = 0; i < array_length(BloonData); i++)
	{
		BloonData[i].upstream = array_create(array_length(BloonData), false);
		BloonData[i].downstream = array_create(array_length(BloonData), false);
	}
	for (var i = array_length(BloonData) - 1; i >= 0; i--)
	{
		var bloonData = BloonData[i];
		bloonData.upstream[i] = true;
		for (var j = 0; j < array_length(bloonData.spawns); j++)
		{
			var spawnData = bloonData.spawns[j].type;
			var ind = array_get_index(BloonOrd, spawnData);
			if (ind == -1) ind = array_get_index(BloonOrd, string_delete(spawnData, 1, 1));
			spawnData = BloonData[ind];
			for (var k = ind; k < array_length(BloonData); k++)
			{
				if (bloonData.upstream[k]) spawnData.upstream[k] = true;
			}
		}
	}
	for (var i = 0; i < array_length(BloonData); i++)
	{
		var bloonData = BloonData[i];
		bloonData.downstream[i] = true;
		for (var j = 0; j < i; j++)
		{
			if (BloonData[j].upstream[i]) bloonData.downstream[i] = true;
		}
	}
}

function parsewavedata()
{
	var waveId = 0;
	while (true)
	{
		nextword();
		if (word == "\r") return;
		else if (word == "{")
		{
			waveId++;
			var data = {type : "red", mods : atr.none, removemods : atr.none, amount : 1, spacing : 30, offset : 0};
			while (true)
			{
				nextword();
				var firstLetter = string_char_at(word, 1);
				if (word == "\r") return;
				else if (word == "}") break;
				else if (firstLetter == "x")
				{
					amount = word;
				}
				else if (firstLetter == "/" || firstLetter == "*")
				{
					spacing = word;
				}
				else if (isletter(firstLetter))
				{
					word = string_lower(word);
					data.mods |= getatrfromstring(word);
				}
				else if (string_length(word) >= 2 && isletter(string_char_at(word, 2)) && (firstLetter == "-" || firstLetter == "+"))
				{
					word = string_lower(string_delete(word, 1, 1));
					if (firstLetter == "-")
					{
						data.removemods |= getatrfromstring(word);
					}
					else
					{
						data.mods |= getatrfromstring(word);
					}
				}
				else
				{
					offset = word;
				}
			}
			WaveData[waveId] = data;
		}
	}
}

function stringify(num, mindigits = 2, maxdigits = 4, forcelessthanzero = true)
{
	var negative = false;
	if (num < 0) { num *= -1; negative = true; }
	var postfix = "";
	if (num >= 1000000000) { num /= 1000000000; postfix = "b"; }
	else if (num >= 1000000) { num /= 1000000; postfix = "m"; }
	else if (num >= 1000) { num /= 1000; postfix = "k"; }
	var str = "";
	str += string(floor(num));
	if (num < 10)
	{
		str += "." + string(floor((10 * num) % 10));
	}
	str += postfix;
	if (negative) str = "-" + str;
	return str;
}

/*
amount modifications type spacing offset

& to make same type as previous
&& to make same type as previous previous
&#& to make same type as nth wave
&-#& to make same type as nth previous wave

#f to denote frames (default)
#s to denote seconds instead of frames (applies to both spacing and offset) (If 3 or less decimal points, will round to nearest frame count)
#/# to denote fraction
#/#^ to enforce rounding to nearest
#/#< to enforce rounding down
#/#> to enforce rounding up
#%^ to enforce rounding to nearest
#%< to enforce rounding down
#%> to enforce rounding up
#.#^ to enforce rounding to nearest
#.#< to enforce rounding down
#.#> to enforce rounding up

x# amount
& relative to amount of previous
&& relative to amount of previous previous
&#& relative to amount of nth wave
&-#& relative to amount of nth previous wave

/# spacing
*# spacing (rate)
:# spacing (total inclusive)
;# spacing (total exlusive)
& relative to rate of previous
&& relative to rate of previous previous
&#& relative to rate of nth wave
&-#& relative to rate of nth previous wave

? all relative to previous (default)
?? all relative to previous previous
?#: all relative to nth wave
?-#? all relative to nth previous wave
| end of previous (default)
|| end of previous previous
|#| end of nth wave
|-#| end of nth previous wave
+ after (default)
- before
% difference in percentage of length of previous
%% difference in percentage of length of previous previous
%#% difference in percentage of length of nth wave
%-#% difference in percentage of length of nth previous wave
& difference in rate of previous
&& difference in rate of previous previous
&#& difference in rate of nth wave
&-#& difference in rate of nth previous wave
_ start of previous
__ start of previous previous
_#_ start of nth wave
_-#_ start of nth previous wave
= start of round
, last bloon of previous
,, 2nd last bloon of previous
,#, nth bloon of previous
,-#, nth last bloon of previous
'' last bloon of previous previous
'#' last bloon of nth wave
'-#' last bloon of nth previous wave
'',, 2nd last bloon of previous previous
'#',#, nth bloon of nth wave
'-#',-#, nth last bloon of nth previous wave
*/