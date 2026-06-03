//Handles stretch ability - upwards
if(canStretch && array_contains(currentStates, playerStates.grounded))
{
	StopRetract();
	StartStretch();
}