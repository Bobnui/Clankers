if collision_point(x - 8, y - 16, O_Player, false, false) && collision_point(x + 8, y - 16, O_Player, false, false)
{
	O_Player.ySpeed = -1 * Bounce_Strength;
	image_speed = 0.5;
	shouldPlay = true;
	var _bounceIndex = irandom(array_length(BounceSounds) - 1)
	var randomBounce = BounceSounds[_bounceIndex];
	audio_play_sound(randomBounce, 1, false, 1, 0, 0.9);
	O_Player.currentLaserLength=0;
	O_Player.EndLasers();
	O_Player.currentExtendAmount=0;
	O_Player.PerformRecall();
	O_Player.canLaser=false;
	O_Player.canExtend=false;
	alarm[0] = delay;
}


	