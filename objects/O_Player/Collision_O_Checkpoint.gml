if currentCheckpoint != other
{
	if currentCheckpoint != noone
	{
		currentCheckpoint.UnsetCheckpoint();
	}
	currentCheckpoint = other;
	currentCheckpoint.SetNewCheckpoint();
}