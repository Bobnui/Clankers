if currentCheckpoint != other // If the current checkpoint is different from the collided one
{
	if currentCheckpoint != noone // and the current checkpoint isn't an empty variable
	{
		currentCheckpoint.UnsetCheckpoint(); //Then unset the the current checkpoint
	}
	currentCheckpoint = other; // Set the current checkpoint to this one
	currentCheckpoint.SetNewCheckpoint(); // and change its appearance / play some sound
}