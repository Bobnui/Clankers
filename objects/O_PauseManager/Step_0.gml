if keyboard_check_pressed(vk_escape)
{
	gamePaused = !gamePaused;
	if gamePaused
	{
		//Display Pause menu
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
