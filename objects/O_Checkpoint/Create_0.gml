image_speed = 0; // Stop sprite from animating
image_index = 0; // set frame to an 'Unset' checkpoint - the one where the light is off

lightSwitchSounds = //An array of sounds
[
	snd_LightSwitch_01,
	snd_LightSwitch_02
]

function SetNewCheckpoint() // when this checkpoint is activated
{
	image_index = 1; // change the sprite to be lit up
	
	var _switchIndex = irandom(array_length(lightSwitchSounds) - 1) //select a switch sound to play
	var randomSwitch = lightSwitchSounds[_switchIndex];
	audio_play_sound(randomSwitch, 1, false, 1, 0, 0.9); // play the sound
	
	var checkpointPitch = (irandom(40) / 100) + 0.8; // select a pitch to play other sound
	audio_play_sound(snd_Checkpoint, 1, false, 1, 0, checkpointPitch) // play that sound too
}

function UnsetCheckpoint() // when this checkpoint is deactivated
{
	image_index = 0; // change sprite to be unlit
}