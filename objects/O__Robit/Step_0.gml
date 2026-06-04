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
		// if player is currently hanging from the roof
		if(array_contains(currentStates, playerStates.hanging)) 
		{
			AttachToGround() // retract from roof to ground
		}
		
		//Or if the player collides with roof from the ground
		else if(collision_point(x, y - (currentStretchAmount + wheelsHeight + 2), o_Collision, false, true))
		{
			AttachToRoof(); // retract from floor to roof
		}
	}
	
	// Or if player states contains falling instead
	if(array_contains(currentStates, playerStates.falling)) || !(array_contains(currentStates, playerStates.grounded)) 
	{
		NewRemoveState(playerStates.falling); // remove it
		NewDesiredState(playerStates.grounded); // and add grounded
	}
}

else if(collision_point(x, y - (currentStretchAmount + wheelsHeight + 2), o_Collision, false, true)) // if there is a collision object directly above the player
{
	currentYSpeed = 0; // Stop player from falling through floor
}

//Otherwise
else 
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