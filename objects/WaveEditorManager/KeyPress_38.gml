waveSelectionInd -= 1;
if (waveSelectionInd < 0) waveSelectionInd = 0;
if (waveSelectionInd >= array_length(WaveData)) waveSelectionInd = array_length(WaveData) - 1;
selectedWave = WaveData[waveSelectionInd];
groupSelectionInd = -1;
selectedGroup = -1;