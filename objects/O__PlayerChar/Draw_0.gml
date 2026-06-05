//Tells engine that this event will handle drawing sprites
draw_self()

//DEBUG
draw_sprite(S__DEBUG, 0, x - 7, GetTopOfHead());
draw_sprite(S__DEBUG, 0, x + 7, GetTopOfHead());

if isGrounded
{
	switch(state)
	{
		case states.idle:
			draw_sprite_ext(s_Robot_Torso, 0, x, GetTopOfHead(), image_xscale, 1, 0, c_white, 1);
			break;
		case states.walking:
			draw_sprite_ext(s_Robot_Torso, walkFrame, x, GetTopOfHead(), image_xscale, 1, 0, c_white, 1);
			break;
		case states.stretching:
			draw_sprite_ext(s_Robit_hangin, 0, x, GetTopOfHead(), image_xscale, 1, 0, c_white, 1);
			break;
	}
}
else if isHanging
{
	
}
else 
{
	draw_sprite_ext(s_Robit_hangin, 0, x, GetTopOfHead(), image_xscale, 1, 0, c_white, 1);
}

//Stretch
draw_sprite_ext(s_Robot_Middle_Bit, 0, x, y - 10, image_xscale, currentStretchAmount, 0, c_white, 1);