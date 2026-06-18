if keyboard_check_pressed(vk_escape)
{
	gamePaused = !gamePaused;
	if gamePaused
	{
		//Display Pause menu
				instance_create_layer(O_Player.x,O_Player.y-10 - (O_Player.currentStretchAmount * .5),"Notifications",o_Pause_Menu)
		if time_source_exists(time_source_game)
		{
			time_source_pause(time_source_game);
		}
	}
	else
	{
		//Get rid of pause menu
		if (time_source_exists(time_source_game)) 
		{
            time_source_resume(time_source_game);
		}
	}
}
