if !O_PauseManager.gamePaused
{
	draw_sprite_ext(S_UI, 0, x - 80, y - 20, 4, 4, 0, c_white, 1);
	
	draw_sprite_ext(UI_Garbage, 0, x + 1850, y + 1080, 8, 8, 0, c_white, 1);
	
	draw_sprite_ext(s_Disk_UI, 0, x + 230, y + 75, 9, 9, 0, c_black, .4);
	draw_sprite_ext(s_Disk_UI, 0, x + 230, y + 75, 8, 8, 0, c_white, 1);
	
	var myScale = 1;
	var xPos = 0;
	if O_PickUpsManager.CollectableCount < 10
	{
		myScale = 10;
		xPos = 254;
	}
	else if O_PickUpsManager.CollectableCount < 100
	{
		myScale = 6;
		font_width = 36
		xPos = 250;
	}
	else
	{
		myScale = 4;
		font_width = 26
		xPos = 244;
	}
	Draw_Font(O_PickUpsManager.CollectableCount, x + xPos, y + 160, true, myScale);
}