function Pickup(_instance)
{
	instance_destroy(_instance);
	audio_play_sound(snd_Pickup, 1, false, 1, 0, 1 + (random(.1) - .05));
	o_Game.pickup_score ++;
}
