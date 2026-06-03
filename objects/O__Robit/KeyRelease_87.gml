//Handles releasing stretch up
if(array_contains(currentStates, playerStates.stretching)) && (array_contains(currentStates, playerStates.grounded))
{
	StopStretch()
	StartRetract();
}
else
{
	show_debug_message("Key Up - W");
}