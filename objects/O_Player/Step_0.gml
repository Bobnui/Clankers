// Get all relevant input for current frame
GetInput(); 

// Checks if player is on the ground
GroundedCheck(); 

//Calculates how the player should move
CalculateSpeed(); 

//Collision Detection
CeilingCheck();
WallCheck();

//checks if player sprites need to be flipped
SetSpriteDirection();

//Moves player
ApplyMovement(); 