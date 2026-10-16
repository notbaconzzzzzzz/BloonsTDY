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
	if (keyboard_check_pressed(189)) // -
	{
		selectedGroup.amt -= 1;
		if (selectedGroup.amt < 1) selectedGroup.amt = 1;
		flag = true;
	}
	if (keyboard_check_pressed(187)) // =
	{
		selectedGroup.amt += 1;
		flag = true;
	}
	if (keyboard_check_pressed(220)) // \
	{
		selectedGroup.amt = 1;
		flag = true;
	}
	if (keyboard_check_pressed(186)) // ;
	{
		selectedGroup.spacing -= 1;
		if (selectedGroup.spacing < 0) selectedGroup.spacing = 0;
		flag = true;
	}
	if (keyboard_check_pressed(222)) // '
	{
		selectedGroup.spacing += 1;
		flag = true;
	}
	if (keyboard_check_pressed(188)) // ,
	{
		selectedGroup.offset -= 1;
		flag = true;
	}
	if (keyboard_check_pressed(190)) // .
	{
		selectedGroup.offset += 1;
		flag = true;
	}
	if (keyboard_check_pressed(191)) // /
	{
		selectedGroup.offset = 0;
		flag = true;
	}
	if (flag) recalculatewaveinfo(waveSelectionInd);
}
/*
if (keyboard_check_pressed(vk_anykey)) {
    show_debug_message("Key pressed: " + string(keyboard_lastkey));
}