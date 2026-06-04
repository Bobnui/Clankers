//Input Values
xInput = 0;
yInput = 0;

//Movement Values
xSpeed = 0;
ySpeed = 0;
moveSpeed = 1;
gravityScale = 1;

//Player State
enum states
{
	idle, // 0
	walking, // 1
	falling, // 2
	stretching, // 3
	hovering, // 4
}

state = states.idle;