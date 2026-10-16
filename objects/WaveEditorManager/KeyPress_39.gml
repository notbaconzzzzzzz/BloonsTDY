if (groupSelectionInd == -1) groupSelectionInd = 0;
else groupSelectionInd += 1;
if (groupSelectionInd < 0 || groupSelectionInd >= array_length(selectedWave)) groupSelectionInd = -1;
selectedGroup = groupSelectionInd == -1 ? -1 : selectedWave[groupSelectionInd];