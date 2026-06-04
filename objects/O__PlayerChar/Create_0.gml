//Input Values
xInput = 0;
yInput = 0;

//Movement Values
xSpeed = 0;
ySpeed = 0;
moveSpeed = 1;
gravityScale = 1;

//Floor & ceiling checks
isGrounded = false;
isHanging = false;

//Player State
enum states
{
	idle, // 0
	walking, // 1
	falling, // 2
	stretching, // 3
}

state = states.idle;