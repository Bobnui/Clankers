//Tells engine that this event will handle drawing sprites
draw_self()


if (currentStretchAmount > 0)
{
	draw_sprite_ext(S__Robit_Mid, 0, x, y - 5, image_xscale, currentStretchAmount, 0, c_white, 1);
}