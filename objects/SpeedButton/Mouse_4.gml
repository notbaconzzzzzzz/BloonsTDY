
if (MenuManager.currentMenu != "none") return;
if (GameManager.gameSpeed != 0 && keyboard_check(vk_control)) GameManager.gameSpeed = 0;
else if (keyboard_check(vk_shift)) GameManager.gameSpeed += 1;
else if (GameManager.gameSpeed == 1) GameManager.gameSpeed = 2;
else GameManager.gameSpeed = 1;
value = GameManager.gameSpeed;