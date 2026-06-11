//DEBUG
DEBUG();
if !O_PauseManager.gamePaused
{
	// Get all relevant input for current frame
	GetInput(); 

	//Calculates how the player should move
	CalculateSpeed(); 

	//Collision Detection
	GroundedCheck(); 
	CeilingCheck();
	WallCheck();
	HangingGapCheck();
	PickUpCheck();

	PlatformCheck();

	//checks if player sprites need to be flipped
	SetSpriteDirection();
	UpdateHangingSprite();

	//Moves player
	ApplyMovement(); 

	//Stretch Ability
	if stretchUnlocked
	{
		StretchCheck();
	}
	
	if extendoArmUnlocked
	{
		ExtendoCheck();
	}
	
	AttachCheck();
	StretchOffsetCheck();

	//Hover Ability
	if hoverUnlocked
	{
		HoverCheck();	
	}

	//Audio
	XMoveAudio();
	StretchAudio();
}
else
{
	image_speed = 0;
}