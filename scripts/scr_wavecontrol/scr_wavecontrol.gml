function resolveoffset(wave, ind, seen = [])
{
	var group = wave[ind];
	if (group.offsetreference < 0 || group.offsetreference >= array_length(wave) || group.offsetreference == ind || array_contains(seen, group)) return group.offset;
	array_push(seen, ind);
	return resolveoffset(wave, group.offsetreference, seen) + wavegrouplength(wave[group.offsetreference]) + group.offset;
}

function wavegrouplength(group, last = true)
{
	if (last) return group.amt * group.spacing;
	return (group.amt - 1) * group.spacing;
}

function recalculatewaveinfo(ind)
{
	var wave = WaveData[ind];
	var info = WaveInfo[ind];
	var num = 0;
	var longestTime = 0;
	for (var i = 0; i < array_length(wave); i++)
	{
		var group = wave[i];
		num += group.amt * group.bloonData.money;
		var resolvedTime = resolveoffset(wave, i);
		group._resolvedTime = resolvedTime;
		var endTime = resolvedTime + wavegrouplength(group, false);
		if (endTime > longestTime) longestTime = endTime;
	}
	var bloonIncomeFactor = 100;
	var roundIncomeFactor = 100;
	if (ind >= 51)  { bloonIncomeFactor = 80; roundIncomeFactor = 120; }
	if (ind >= 61)  { bloonIncomeFactor = 50; roundIncomeFactor = 150; }
	if (ind >= 86)  { bloonIncomeFactor = 34; roundIncomeFactor = 200; }
	if (ind >= 101) { bloonIncomeFactor = 20; roundIncomeFactor = 300; }
	if (ind >= 121) { bloonIncomeFactor = 10; roundIncomeFactor = 500; }
	info.money = num * bloonIncomeFactor / 100 + round((100 + ind) * roundIncomeFactor / 100);
	info.length = longestTime;
}

function initializenewwave()
{
	array_push(WaveData, []);
	array_push(WaveInfo, { length : 0, money : 0 });
	waveSelectionInd = array_length(WaveData) - 1;
	selectedWave = WaveData[waveSelectionInd];
	groupSelectionInd = array_length(selectedWave) - 1;
	selectedGroup = groupSelectionInd == -1 ? -1 : selectedWave[groupSelectionInd];
	if (selectedWave != -1) recalculatewaveinfo(waveSelectionInd);
}

function initializenewgroup()
{
	array_push(selectedWave, { typeIndex : 0, bloonData : DataManager.BloonData[0], amt : 1, mods : atr.none, spacing : 30, offset : 0, offsetreference : -1 });
	groupSelectionInd = array_length(selectedWave) - 1;
	selectedGroup = groupSelectionInd == -1 ? -1 : selectedWave[groupSelectionInd];
	recalculatewaveinfo(waveSelectionInd);
}