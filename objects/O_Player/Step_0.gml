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
	ExtendoCollision();
	DestructoCheck();

	//checks if player sprites need to be flipped
	SetSpriteDirection();
	UpdateHangingSprite();

	//Moves player
	ApplyMovement(); 

	//Stretch Ability
	if O_PickUpsManager.stretchUnlocked
	{
		StretchCheck();
	}
	
	if O_PickUpsManager.extendoArmUnlocked
	{
		ExtendoCheck();
	}
	
	AttachCheck();
	StretchOffsetCheck();

	//Hover Ability
	if O_PickUpsManager.hoverUnlocked
	{
		HoverCheck();	
	}
	if O_PickUpsManager.laserUnlocked
	{
		LaserEyeCheck();	
	}

	//Audio
	XMoveAudio();
	StretchAudio();
}
else
{
	image_speed = 0;
}