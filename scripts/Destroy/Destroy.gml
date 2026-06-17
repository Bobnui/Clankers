enum DestroyType
{
	Wall
}

function DestructoWall(_wall, DestroyType)
{
	instance_destroy(_wall);
	//audio_play_sound(snd_Pickup, 1, false, 1, 0, 1 + (random(.1) - .05));
}

