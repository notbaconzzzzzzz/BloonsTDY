function menufunction(func, operand)
{
	switch(func)
	{
		case "menu":
			gotomenu(operand);
			break;
		case "room":
			gotoroom(operand);
			break;
	}
}

function sliderfunction(func, value)
{
	switch(func)
	{
		case "setmusicvolume":
			SettingsManager.MusicVolume = value * 2;
			audio_group_set_gain(Music, SettingsManager.MusicVolume);
			break;
		case "setsfxvolume":
			SettingsManager.SfxVolume = value * 2;
			audio_group_set_gain(audiogroup_default, SettingsManager.SfxVolume);
			break;
		case "setpopvolume":
			SettingsManager.PopVolume = value * 2;
			break;
		case "setdmgvolume":
			SettingsManager.DmgVolume = value * 2;
			break;
		case "sethitvolume":
			SettingsManager.HitVolume = value * 2;
			break;
	}
}

function createbutton(bx, by, label, func, operand)
{
	instance_create_layer(bx, by, "Menu", MenuButton, {label : label, func : func, operand : operand});
}

function createslider(bx, by, label, func, value)
{
	instance_create_layer(bx, by, "Menu", MenuSlider, {label : label, func : func, value : value});
}

function gotomenu(menu)
{
	if (menu == "default")
	{
		onnewroom();
		return;
	}
	with (MenuButton) instance_destroy();
	with (MenuManager)
	{
		currentMenu = menu;
		switch (menu)
		{
			case "none":
				createbutton(room_width - 200, 100, "Settings", "menu", "settings");
				break;
			case "mainmenu":
				createbutton(room_width / 2, room_height / 2, "Start", "room", "game");
				break;
			case "settings":
				createbutton(room_width - 200, 100, "Close", "menu", "default");
				createslider(room_width / 2, room_height / 2 - 100, "Music Volume", "setmusicvolume", SettingsManager.MusicVolume / 2);
				createslider(room_width / 2, room_height / 2 - 50, "SFX Volume", "setsfxvolume", SettingsManager.SfxVolume / 2);
				createslider(room_width / 2, room_height / 2 + 50, "Pop Sounds", "setpopvolume", SettingsManager.PopVolume / 2);
				createslider(room_width / 2, room_height / 2 + 100, "Damage Sounds", "setdmgvolume", SettingsManager.DmgVolume / 2);
				createslider(room_width / 2, room_height / 2 + 150, "Cant-Hit Sounds (important)", "sethitvolume", SettingsManager.HitVolume / 2);
				break;
		}
	}
}

function onnewroom()
{
	switch(room)
	{
		case Game:
			gotomenu("none");
			break;
		case MainMenu:
			gotomenu("mainmenu");
			break;
	}
}

function gotoroom(r)
{
	with (MenuManager)
	{
		switch (r)
		{
			case "mainmenu":
				room_goto(MainMenu);
				break;
			case "game":
				room_goto(Game);
				break;
		}
	}
}