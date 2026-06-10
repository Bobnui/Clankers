if keyboard_check_pressed(vk_escape)
{
	gamePaused = !gamePaused;
	if gamePaused
	{
		if time_source_exists(time_source_game)
		{
			time_source_pause(time_source_game);
		}
	}
	else
	{
		if (time_source_exists(time_source_game)) 
		{
            time_source_resume(time_source_game);
		}
	}
}
