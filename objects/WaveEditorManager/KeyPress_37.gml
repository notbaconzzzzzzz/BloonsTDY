if (keyboard_check(vk_control))
{
	if (groupSelectionInd == -1) return;
	if (groupSelectionInd > 0)
	{
		groupSelectionInd -= 1;
		selectedWave[groupSelectionInd + 1] = selectedWave[groupSelectionInd];
		selectedWave[groupSelectionInd] = selectedGroup;
		if (keyboard_check(vk_shift))
		{
			for (var i = 0; i < array_length(selectedWave); i++)
			{
				//if (i == groupSelectionInd) continue;
				//if (i == groupSelectionInd + 1) continue;
				var group = selectedWave[i];
				if (group.offsetreference == groupSelectionInd)
				{
					group.offsetreference = groupSelectionInd + 1;
				}
				else if (group.offsetreference == groupSelectionInd + 1)
				{
					group.offsetreference = groupSelectionInd;
				}
			}
		}
		else
		{
			var temp = selectedGroup.offsetreference;
			selectedGroup.offsetreference = selectedWave[groupSelectionInd + 1].offsetreference;
			selectedWave[groupSelectionInd + 1].offsetreference = temp;
			temp = selectedGroup.offset;
			selectedGroup.offset = selectedWave[groupSelectionInd + 1].offset;
			selectedWave[groupSelectionInd + 1].offset = temp;
		}
		recalculatewaveinfo(waveSelectionInd);
	}
}
else
{
	if (groupSelectionInd == -1) groupSelectionInd = array_length(selectedWave) - 1;
	else groupSelectionInd -= 1;
	if (groupSelectionInd < 0 || groupSelectionInd >= array_length(selectedWave)) groupSelectionInd = -1;
	selectedGroup = groupSelectionInd == -1 ? -1 : selectedWave[groupSelectionInd];
}