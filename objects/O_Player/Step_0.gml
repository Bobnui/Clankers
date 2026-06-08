//DEBUG
DEBUG();

// Get all relevant input for current frame
GetInput(); 

// Checks if player is on the ground
GroundedCheck(); 

//Calculates how the player should move
CalculateSpeed(); 

//Collision Detection
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
HoverCheck();

//Audio
XMoveAudio();
StretchAudio();