var shift = keyboard_check(vk_shift);
var alt = keyboard_check(vk_alt);
var control = keyboard_check(vk_control);
if (selectedGroup != -1)
{
	var flag = false;
	if (keyboard_check_pressed(219)) // [
	{
		selectedGroup.typeIndex -= 1;
		if (selectedGroup.typeIndex < 0) selectedGroup.typeIndex = 0;
		selectedGroup.bloonData = DataManager.BloonData[selectedGroup.typeIndex];
		flag = true;
	}
	if (keyboard_check_pressed(221)) // ]
	{
		selectedGroup.typeIndex += 1;
		if (selectedGroup.typeIndex >= array_length(DataManager.BloonData)) selectedGroup.typeIndex = array_length(DataManager.BloonData) - 1;
		selectedGroup.bloonData = DataManager.BloonData[selectedGroup.typeIndex];
		flag = true;
	}
	if (keyboard_check_pressed(220)) // \
	{
		if (selectedGroup.typeIndex < 11) selectedGroup.typeIndex = 11;
		else if (selectedGroup.typeIndex < 18) selectedGroup.typeIndex = 18;
		else if (selectedGroup.typeIndex < 22) selectedGroup.typeIndex = 22;
		else if (selectedGroup.typeIndex < 25) selectedGroup.typeIndex = 25;
		else if (selectedGroup.typeIndex < 30) selectedGroup.typeIndex = 30;
		else if (selectedGroup.typeIndex < 37) selectedGroup.typeIndex = 37;
		else selectedGroup.typeIndex = 0;
		selectedGroup.bloonData = DataManager.BloonData[selectedGroup.typeIndex];
		flag = true;
	}
	if (keyboard_check_pressed(189)) // -
	{
		if (shift) selectedGroup.amt = ceil(selectedGroup.amt / 5 - 1) * 5;
		else selectedGroup.amt -= 1;
		if (selectedGroup.amt < 1) selectedGroup.amt = 1;
		flag = true;
	}
	if (keyboard_check_pressed(187)) // =
	{
		if (shift) selectedGroup.amt = floor(selectedGroup.amt / 5 + 1) * 5;
		else selectedGroup.amt += 1;
		flag = true;
	}
	if (keyboard_check_pressed(186)) // ;
	{
		if (shift) selectedGroup.spacing = ceil(selectedGroup.spacing / 5 - 1) * 5;
		else selectedGroup.spacing -= 1;
		if (selectedGroup.spacing < 0) selectedGroup.spacing = 0;
		flag = true;
	}
	if (keyboard_check_pressed(222)) // '
	{
		if (shift) selectedGroup.spacing = floor(selectedGroup.spacing / 5 + 1) * 5;
		else selectedGroup.spacing += 1;
		flag = true;
	}
	if (keyboard_check_pressed(188)) // ,
	{
		if (control)
		{
			if (shift) selectedGroup.offset = selectedGroup._resolvedTime;
			if (selectedGroup.offsetreference == -1) selectedGroup.offsetreference = groupSelectionInd;
			selectedGroup.offsetreference -= 1;
			if (selectedGroup.offsetreference < 0 || selectedGroup.offsetreference == groupSelectionInd) selectedGroup.offsetreference = -1;
			if (shift)
			{
				var resolvedOffset = inverseresolveoffset(selectedWave, groupSelectionInd, selectedGroup.offset);
				selectedGroup.offset = resolvedOffset;
				selectedGroup._resolvedTime = resolveoffset(selectedWave, groupSelectionInd);
			}
			flag = true;
		}
		else
		{
			if (shift && alt) selectedGroup.offset = ceil(selectedGroup.offset / selectedGroup.spacing - 1) * selectedGroup.spacing;
			else if (shift) selectedGroup.offset = ceil(selectedGroup.offset / 60 - 1) * 60;
			else if (alt) selectedGroup.offset -= 1;
			else selectedGroup.offset -= 5;
			flag = true;
		}
	}
	if (keyboard_check_pressed(190)) // .
	{
		if (control)
		{
			if (shift) selectedGroup.offset = selectedGroup._resolvedTime;
			if (selectedGroup.offsetreference == -1) selectedGroup.offsetreference = groupSelectionInd;
			selectedGroup.offsetreference += 1;
			if (selectedGroup.offsetreference >= array_length(selectedWave) || selectedGroup.offsetreference == groupSelectionInd) selectedGroup.offsetreference = -1;
			if (shift)
			{
				var resolvedOffset = inverseresolveoffset(selectedWave, groupSelectionInd, selectedGroup.offset);
				selectedGroup.offset = resolvedOffset;
				selectedGroup._resolvedTime = resolveoffset(selectedWave, groupSelectionInd);
			}
			flag = true;
		}
		else
		{
			if (shift && alt) selectedGroup.offset = floor(selectedGroup.offset / selectedGroup.spacing + 1) * selectedGroup.spacing;
			else if (shift) selectedGroup.offset = floor(selectedGroup.offset / 60 + 1) * 60;
			else if (alt) selectedGroup.offset += 1;
			else selectedGroup.offset += 5;
			flag = true;
		}
	}
	if (keyboard_check_pressed(191)) // /
	{
		if (control)
		{
			if (shift) selectedGroup.offset = selectedGroup._resolvedTime;
			selectedGroup.offsetreference = -1;
			flag = true;
		}
		else
		{
			selectedGroup.offset = 0;
			flag = true;
		}
	}
	if (flag) recalculatewaveinfo(waveSelectionInd);
}
if (max(waveSelectionInd - 2, 0) < verticalScroll) verticalScroll -= 1;
if (min(waveSelectionInd - 6, array_length(WaveData) - 8) > verticalScroll) verticalScroll += 1;
/*
if (keyboard_check_pressed(vk_anykey)) {
    show_debug_message("Key pressed: " + string(keyboard_lastkey));
}