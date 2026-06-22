if collision_point(x - 8, y - 16, O_Player, false, false) && collision_point(x + 8, y - 16, O_Player, false, false)
{ // if the player is fully on the jumpPad
	O_Player.ySpeed -= Bounce_Strength; // add the bounce strength of the jumpPad to the player
	image_speed = 0.5; // play the jumpPad animation at half speed
	var _bounceIndex = irandom(array_length(BounceSounds) - 1) //pick a bounce sound to play
	var randomBounce = BounceSounds[_bounceIndex];
	audio_play_sound(randomBounce, 1, false, 1, 0, 0.9); // play it
}
