waveSelectionInd++;
if (waveSelectionInd >= array_length(WaveData))
{
	initializenewwave();
}
else
{
	selectedWave = WaveData[waveSelectionInd];
	groupSelectionInd = array_length(selectedWave) - 1;
	selectedGroup = groupSelectionInd == -1 ? -1 : selectedWave[groupSelectionInd];
}