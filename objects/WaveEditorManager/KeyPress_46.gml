if (selectedWave != -1)
{
	if (keyboard_check(vk_control))
	{
		if (array_length(WaveData) <= 1) return;
		array_delete(WaveData, waveSelectionInd, 1);
		array_delete(WaveInfo, waveSelectionInd, 1);
		waveSelectionInd -= 1;
		if (waveSelectionInd < 0) waveSelectionInd = 0;
		selectedWave = WaveData[waveSelectionInd];
		groupSelectionInd = -1;
		selectedGroup = -1;
		for (var i = waveSelectionInd + 1; i < array_length(WaveData); i++)
		{
			recalculatewaveinfo(i);
		}
	}
	else
	{
		if (selectedGroup == -1)
		{
			if (array_length(selectedWave) <= 0) return;
			groupSelectionInd = array_length(selectedWave) - 1;
			selectedGroup = groupSelectionInd == -1 ? -1 : selectedWave[groupSelectionInd];
		}
		array_delete(selectedWave, groupSelectionInd, 1);
		groupSelectionInd -= 1;
		selectedGroup = groupSelectionInd == -1 ? -1 : selectedWave[groupSelectionInd];
		recalculatewaveinfo(waveSelectionInd);
	}
}