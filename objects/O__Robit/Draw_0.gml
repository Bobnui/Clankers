//Tells engine that this event will handle drawing sprites
draw_self()


if (currentStretchAmount > 0)
{
	draw_sprite_ext(s_Robot_Middle_Bit, 0, x, y - (0.5 * wheelsHeight), image_xscale, currentStretchAmount, 0, c_white, 1);
}