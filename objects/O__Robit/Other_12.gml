//Hover ability - added on pickup
canHover = true;

StopHovering = function()
{
	NewRemoveState(playerStates.hovering);
	
	gravityScale = 1;
}

HoverTimer = time_source_create(time_source_game, maxHoverLength, time_source_units_seconds, StopHovering);

StartHovering = function()
{		
	NewDesiredState(playerStates.hovering); // tell state machine that we are hovering
	
	time_source_start(HoverTimer);
	
	gravityScale = 0;
}
