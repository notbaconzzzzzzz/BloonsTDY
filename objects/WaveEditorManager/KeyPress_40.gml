if (keyboard_check(vk_control))
{
	if (waveSelectionInd < array_length(WaveData) - 1)
	{
		waveSelectionInd += 1;
		WaveData[waveSelectionInd - 1] = WaveData[waveSelectionInd];
		WaveData[waveSelectionInd] = selectedWave;
		recalculatewaveinfo(waveSelectionInd - 1);
		recalculatewaveinfo(waveSelectionInd);
	}
}
else
{
	waveSelectionInd += 1;
	if (waveSelectionInd < 0) waveSelectionInd = 0;
	if (waveSelectionInd >= array_length(WaveData)) waveSelectionInd = array_length(WaveData) - 1;
	selectedWave = WaveData[waveSelectionInd];
	groupSelectionInd = -1;
	selectedGroup = -1;
}