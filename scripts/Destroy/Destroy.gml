enum DestroyType
{
	Wall
}

function DestructoWall(_wall, DestroyType)
{
	instance_destroy(_wall);
	switch(irandom(3))
	{
	    case 0 : audio_play_sound(snd_woodbreak_1,0,false); break;
	    case 1 : audio_play_sound(snd_woodbreak_2,0,false); break;
	    case 2 : audio_play_sound(snd_woodbreak_3,0,false); break;
	    case 3 : audio_play_sound(snd_woodbreak_4,0,false); break;
	}
}