//Step happens every frame


//MOVEMENT VALUES
currentXSpeed = xInput * moveSpeed;
currentYSpeed = gravityScale;


//COLLISION
//x axis
if place_meeting(x + currentXSpeed, y, o_Collision) // if there is a collision object in player's way
{
	currentXSpeed = 0; // stop them from moving through it
	
	if(array_contains(currentStates, playerStates.walking)) // if player states contain walking
	{
		NewRemoveState(playerStates.walking); // remove it
	}
}

//y axis
if place_meeting(x, y + 1, o_Collision) // if there is a collision object directly below the player
{
	currentYSpeed = 0; // Stop player from falling through floor
	
	//And player is currently stretching
	if(array_contains(currentStates, playerStates.stretching))
	{
		if(array_contains(currentStates, playerStates.hanging)) 
		{
			show_debug_message("Retract From Roof"); // retract from roof to ground
		}
		
		//AND player collides with roof 
		if (collision_point(x - (0.5 * charWidth), y - currentStretchAmount - charHeight, o_Collision, false, false)) 
		&& 
		(collision_point(x + (0.5 * charWidth), y - currentStretchAmount - charHeight, o_Collision, false, false))
		{
			show_debug_message("Retract from floor"); // retract from floor to roof
		}
	}
	// and if player states contains falling
	if(array_contains(currentStates, playerStates.falling)) || !(array_contains(currentStates, playerStates.grounded)) 
	{
		NewRemoveState(playerStates.falling); // remove it
		NewDesiredState(playerStates.grounded); // and add grounded
	}
	
	
}
else //Otherwise
{
	
	if(!array_contains(currentStates, playerStates.falling)) // if player states don't contain falling
	{
		NewDesiredState(playerStates.falling) // add it
		NewRemoveState(playerStates.grounded) // and remove grounded
	}
}

if (currentXSpeed == 0 && currentYSpeed == 0) //if player isn't moving at all
{
	NewDesiredState(playerStates.idle) // add idle state
}
else // otherwise
{
	x += currentXSpeed;
	y += currentYSpeed; //APPLY MOVEMENT
}