// Get all relevant input for current frame
GetInput(); 

// Checks if player is on the ground
GroundedCheck(); 

//Calculates how the player should move
CalculateSpeed(); 

//Collision detection. Also alters player's speed if they would collide with something
WallCheck(); 
FloorCheck();
CeilingCheck();

//checks if player sprites need to be flipped
DirectionCheck(); 

//Moves player
ApplyMovement(); 

//Stretch Ability
StretchCheck();






