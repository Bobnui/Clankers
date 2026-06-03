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
	currentYSpeed = 0; //Stop player from falling
	
	if(array_contains(currentStates, playerStates.hanging) && array_contains(currentStates, playerStates.stretching)) // if player is stretching down from roof
	{
		show_debug_message("Retract From Roof"); // retract from roof to ground
	}
	
	
	if(array_contains(currentStates, playerStates.falling)) // if player states contains falling
	{
		NewRemoveState(playerStates.falling); // remove it
		NewDesiredState(playerStates.grounded); // and add grounded
	}
}
else if(collision_point())
{

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