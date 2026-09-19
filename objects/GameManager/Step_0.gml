/// @description Insert description here
// You can write your code in this editor
if (!BloonRenderer.spawned) return;

for (var i = 0; i < blnsnd.TOTAL_COUNT; i++)
{
	//var data = LocalizeManager.BloonSounds[i];
	var notmaxed = 0;
	for (var j = 0; j < array_length(bloonSoundVariations[i]); j++)
	{
		if (bloonSoundVariations[i][j] < 1) notmaxed++;
	}
	if (notmaxed > 0)
	{
		var rand = irandom(notmaxed-1);
		for (var j = 0; j <= rand; j++)
		{
			if (bloonSoundVariations[i][j] >= 1) rand++;
		}
		bloonSoundVariations[i][rand] += 1;
	}
}

for (var i = 0; i < gameSpeed; i++)
{
	if (true) wait++;
	if (wait >= delay)
	{
		wait = 0;
		var bloonData = spawnrandombloon();
		delay = rate;
		budget -= bloonData.dif;
		if (is_struct(bloonData.moab))
		{
			delay *= 2 * power(2, bloonData.moab.class);
			blns -= 2 * power(2, bloonData.moab.class);
		}
		else
		{
			blns -= 1;
		}
		if (blns <= 0)
		{
			endround();
		}
	}
	with (Bloon) if (instance_exists(id)) event_user(0);
	with (Tower) if (instance_exists(id)) event_user(0);
	with (ProjBase) if (instance_exists(id)) event_user(0);
}

for (var i = 0; i < blnsnd.TOTAL_COUNT; i++)
{
	if (bloonSounds[i] > 0)
	{
		var data = LocalizeManager.BloonSounds[i];
		var vol = SettingsManager.DmgVolume;
		if (i >= blnsnd.hitlead) vol = SettingsManager.HitVolume;
		else if (i >= blnsnd.pop) vol = SettingsManager.PopVolume;
		if (vol > 0)
		{
			var available = 0;
			for (var j = 0; j < array_length(bloonSoundVariations[i]); j++)
			{
				if (bloonSoundVariations[i][j] > 0) available++;
			}
			while (available > 0 && bloonSounds[i] > 0)
			{
				var rand = irandom(available-1);
				for (var j = 0; j <= rand; j++)
				{
					if (bloonSoundVariations[i][j] <= 0) rand++;
				}
				audio_play_sound(data.s[rand], 0, false, data.v * vol, 0, data.p);
				bloonSoundVariations[i][rand] -= 1;
				if (bloonSoundVariations[i][rand] <= 0) available--;
			}
		}
		bloonSounds[i] = 0;
	}
}

if (!audio_is_playing(music))
{
	music = audio_play_sound(LocalizeManager.MusicTracks[irandom(array_length(LocalizeManager.MusicTracks)-1)], 1000, false);
}