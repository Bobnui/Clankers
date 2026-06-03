//State Manager

NewDesiredState = function(newState)
{
	if !array_contains(currentStates, newState)
	{
		switch(newState)
		{
			case playerStates.idle:
				show_debug_message("idle");
				array_push(currentStates, newState);
				break;
			
			case playerStates.walking:
				show_debug_message("walking");
				array_push(currentStates, newState);
				break;
			
			case playerStates.grounded:
				show_debug_message("grounded");
				array_push(currentStates, newState);
				break;
			
			case playerStates.hanging:
				show_debug_message("hanging")
				array_push(currentStates, newState);
				break;
			
			case playerStates.falling:
				show_debug_message("falling");
				array_push(currentStates, newState);
				break;
			
			case playerStates.stretching:
				show_debug_message("stretching");
				array_push(currentStates, newState);
				break;
			
			case playerStates.hovering:
				show_debug_message("hovering");
				array_push(currentStates, newState);
				break;
		}
	}
}

NewRemoveState = function(removeState)
{
	if array_contains(currentStates, removeState)
	{
		tempIndex = array_get_index(currentStates, removeState);
		array_delete(currentStates, tempIndex, 1);
	}
}

MoveInputChanged = function()
{
	if(xInput == 0)
		{
			NewRemoveState(playerStates.walking);
			NewDesiredState(playerStates.idle);
		}
		else
		{
			NewDesiredState(playerStates.walking);
			NewRemoveState(playerStates.idle);
		}
}