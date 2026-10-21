if (selectedWave != -1)
{
	if (keyboard_check(vk_control))
	{
		initializenewwave(waveSelectionInd);
		// if (array_length(WaveData >= 51)) recalculate every wave on the thresholds
	}
	else
	{
		initializenewgroup();
	}
}