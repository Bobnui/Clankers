enum PressType
{
	ButtonWall
}

function PressButton(_butt,PressType)
{
	instance_destroy(_butt.DoorID);
	//audio_play_sound(snd_Pickup, 1, false, 1, 0, 1 + (random(.1) - .05));
}
