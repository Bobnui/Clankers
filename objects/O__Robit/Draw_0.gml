//Tells engine that this event will handle drawing sprites
draw_self()

draw_sprite(s_Ceiling, 1, x + currentXSpeed, y)

#region Draw Torso
//Highest priority torso sprites at top

//Grounded
if(array_contains(currentStates, playerStates.grounded))
{
	//Stretching
	if (array_contains(currentStates, playerStates.stretching))
	{
		DrawTorso(s_Robot_Torso, 1);
	}
	//Hanging
	else if (array_contains(currentStates, playerStates.retracting))
	{
		DrawTorso(s_Robot_Torso, 2);
	}
	//Grounded Default
	else
	{
		DrawTorso(s_Robot_Torso, 0);
	}
}

//Hanging
else if(array_contains(currentStates, playerStates.hanging))
{
	DrawTorso(s_Robit_hangin, 0);
}

//falling
else if(array_contains(currentStates, playerStates.falling))
{
	DrawTorso(s_Robit_hangin, 0);
}

//Default
else
{
	DrawTorso(s_Robot_Torso, 0);
}
#endregion


if (currentStretchAmount > 0)
{
	draw_sprite_ext(s_Robot_Middle_Bit, 0, x, y - (0.5 * wheelsHeight), image_xscale, currentStretchAmount, 0, c_white, 1);
}