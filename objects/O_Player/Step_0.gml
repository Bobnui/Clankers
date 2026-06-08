//DEBUG
DEBUG();

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