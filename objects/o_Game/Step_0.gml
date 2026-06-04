if instance_number(o_Magnet) == 0
{
	_room = room_next(room);
	if room_exists(_room)
	{
		pause = true;
		change_level = true;
	}
}

if change_level == true
{
	pause_count ++;
	if pause_count > pause_limit
	{
		pause_count	= 0;
		pause = false;
		current_level ++;
		change_level = false;
		
		room_goto_next();
	}
}
