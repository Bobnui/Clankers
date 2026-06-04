//Handles releasing stretch down
if(array_contains(currentStates, playerStates.stretching)) && (array_contains(currentStates, playerStates.hanging))
{
	StopStretch()
	StartRetract();
}
else
{
	
}