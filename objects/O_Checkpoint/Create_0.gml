image_speed = 0;
image_index = 0;

lightSwitchSounds = 
[
	snd_LightSwitch_01,
	snd_LightSwitch_02
]

function SetNewCheckpoint()
{
	image_index = 1;
	
	var _switchIndex = irandom(array_length(lightSwitchSounds) - 1)
	var randomSwitch = lightSwitchSounds[_switchIndex];
	audio_play_sound(randomSwitch, 1, false, 1, 0, 0.9);
	
	var checkpointPitch = (irandom(40) / 100) + 0.8;
	audio_play_sound(snd_Checkpoint, 1, false, 1, 0, checkpointPitch)
}

function UnsetCheckpoint()
{
	image_index = 0;
}