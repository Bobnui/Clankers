//Tells engine that this event will handle drawing sprites
draw_self()

if(isGrounded)
{
	switch(state)
	{
		case states.idle:
			draw_sprite_ext(s_Robot_Torso, 0, x, y - currentStretchAmount, image_xscale, 1, 0, c_white, 1);
			break;
		case states.walking:
			draw_sprite_ext(s_Robot_Torso, walkFrame, x, y - currentStretchAmount, image_xscale, 1, 0, c_white, 1);
			break;
		case states.stretching:
			draw_sprite_ext(s_Robit_hangin, 0, x, y - currentStretchAmount, image_xscale, 1, 0, c_white, 1);
			break;
	}
}