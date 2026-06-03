//Stretch Ability - Added on Pickup
canStretch = true;

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
	currentStretchAmount -= 1;

	
	if(currentStretchAmount <= 0)
	{
		StopRetract();
		NewRemoveState(playerStates.stretching);
	}
}

	StretchTimer = time_source_create(time_source_game, 1, time_source_units_frames, PerformStretch, [], -1);
	RetractTimer = time_source_create(time_source_game, 1, time_source_units_frames, PerformRetract, [], -1);
	
StartStretch = function()
{
	NewDesiredState(playerStates.stretching);

	time_source_start(StretchTimer);
}

StopStretch = function()
{
	time_source_reset(StretchTimer);
}

StartRetract = function()
{

	time_source_start(RetractTimer);
}

StopRetract = function()
{
	time_source_reset(RetractTimer);
}
