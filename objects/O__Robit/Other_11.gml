//Stretch Ability - Added on Pickup
canStretch = true;
shouldAttach = false;

#region Perform Stretch / Retract
PerformStretch = function()
{
	currentStretchAmount += 1;
	
	if(currentStretchAmount >= maxStretchLength)
	{
		StopStretch();
	}
}

PerformRetract = function()
{
	currentStretchAmount -= 2;
	
	if(currentStretchAmount <= 0)
	{
		currentStretchAmount = 0;
		StopRetract();
	}
	else
	{
		if(shouldAttach == true)
		{
			y -= 2;
		}
	}
}
#endregion

#region Repeating Timers
	StretchTimer = time_source_create(time_source_game, 1, time_source_units_frames, PerformStretch, [], -1);
	RetractTimer = time_source_create(time_source_game, 1, time_source_units_frames, PerformRetract, [], -1);
#endregion
	
#region Start / Stop - Stretch / Retract
function StartStretch()
{
	NewDesiredState(playerStates.stretching);

	time_source_start(StretchTimer);
}

function StopStretch()
{
	if(shouldAttach)
	{
		gravityScale = 0;
	}
	NewRemoveState(playerStates.stretching);
	
	time_source_reset(StretchTimer);
}

function StartRetract()
{
	NewDesiredState(playerStates.retracting);
	
	time_source_start(RetractTimer);
}

function StopRetract()
{
	if(shouldAttach)
	{
		NewDesiredState(playerStates.hanging);
	}
	NewRemoveState(playerStates.retracting)
	
	time_source_reset(RetractTimer);
	shouldAttach = false;
}
#endregion

#region Attach to Ground / Roof
function AttachToGround()
{
	
}
function AttachToRoof()
{
	StopStretch();
	shouldAttach = true;
	StartRetract();
}
#endregion

#region Bool CheckFunctions
function StretchRectractCheck()
{
	stretchRetract = bool((array_contains(currentStates, playerStates.stretching)) || (array_contains(currentStates, playerStates.retracting)));
	return stretchRetract;
}
#endregion