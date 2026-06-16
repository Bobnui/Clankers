if collision_point(x - 8, y - 16, O_Player, false, false) && collision_point(x + 8, y - 16, O_Player, false, false)
{
	O_Player.ySpeed -= Bounce_Strength;
	image_speed = 0.5;
	shouldPlay = true;
}
