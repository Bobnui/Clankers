enum PressType
{
	ButtonWall
}

function PressButton(_butt,PressType)
{
	if _butt.DoorID.image_yscale > 0
	{
		_butt.DoorID.image_yscale -= 0.1;
	}
	//audio_play_sound(snd_Pickup, 1, false, 1, 0, 1 + (random(.1) - .05));
}
