//Movement Values
xSpeed = 0;
ySpeed = 0;
moveSpeed = 1;
gravityScale = .2;

//Floor & ceiling checks
isGrounded = true;
isHanging = false;

//Sprite
walkFrame = 0;

//Player State
enum states
{
	idle, // 0
	walking, // 1
	falling, // 2
	stretching, // 3
}

state = states.idle;

//Stretch
canStretch = true; //CHANGE THIS LATER !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
currentStretchAmount = 0;
maxStretchAmount = 40;
stretchSpeed = 1;
retractSpeed = 2;
currentlyPulling = false;

#region FUNCTIONS

#region Input
function GetInput() // returns all current input values
{
	leftMoveKey = keyboard_check(ord("A"));
	rightMoveKey = keyboard_check(ord("D"));
	stretchUpKey = keyboard_check(ord("W"));
	stretchDownKey = keyboard_check(ord("S"));
	hoverKey = keyboard_check(vk_space);
	extendoArmKey = keyboard_check_pressed(ord("E"))
}
#endregion

#region Movement
function CalculateSpeed()
{
	xSpeed = (rightMoveKey - leftMoveKey) * moveSpeed; //Sets xSpeed variable based on input & moveSpeed
	if !isGrounded
	{
		ySpeed += gravityScale //if the player isn't on the ground, apply gravity

	}
	else
	{
		ySpeed = 0; //otherwise stop them from clipping through the floor
	}
}
function ApplyMovement() //Add calculated speed to player's current position
{
	x += xSpeed;
	y += ySpeed;
}
#endregion

#region Sprite
function GetTopOfHead()
{
	return y - currentStretchAmount - 22; // This should always return the pixel at the top / center of the head
}

function DirectionCheck()
{
	if rightMoveKey - leftMoveKey != 0 // If the player is currently moving
	{
		image_xscale = rightMoveKey - leftMoveKey; //set their sprite facing the direction they are moving
	}
}
#endregion

#region Checks
function GroundedCheck()
{
	if place_meeting(x, y + 1, o_Collision) // If there is a floor directly below the player
	{
		isGrounded = true;
	}
	else 
	{
		isGrounded = false;
	}
}

function WallCheck()
{
	if place_meeting(x + xSpeed, y, o_Collision) // If there is a wall where play is trying to move
	{
		//move player as close to wall as possible
		var pixelCheckX = sign(xSpeed);
		while !place_meeting(x + pixelCheckX, y, o_Collision)
		{
			x += pixelCheckX;
		}
		//Then prevent player passing through it
		xSpeed = 0;
	}
	//Repeat collision for torso
	else if collision_rectangle(bbox_left + 6 + xSpeed, bbox_top - 4 - currentStretchAmount, bbox_right - 6 + xSpeed, bbox_bottom - 6, o_Collision, false, false)
	{
		var pixelCheckX = sign(xSpeed);
		while !collision_rectangle(bbox_left + 6 + pixelCheckX, bbox_top - 4 - currentStretchAmount, bbox_right - 6 + pixelCheckX, bbox_bottom - 6, o_Collision, false, false)
		{
			x += pixelCheckX;
		}
		xSpeed = 0;
	}
	//repeat collision for shoulders
	else if collision_rectangle(bbox_left + 4 + xSpeed, bbox_top - 9 - currentStretchAmount, bbox_right - 4 + xSpeed, bbox_bottom - 12 - currentStretchAmount, o_Collision, false, false)
	{
		var pixelCheckX = sign(xSpeed);
		while !collision_rectangle(bbox_left + 4 + pixelCheckX, bbox_top - 9 - currentStretchAmount, bbox_right - 4 + pixelCheckX, bbox_bottom - 12 - currentStretchAmount, o_Collision, false, false)
		{
			x += pixelCheckX;
		}
		xSpeed = 0;
	}
	//repeat collision for head
	else if collision_rectangle(bbox_left + 7 + xSpeed, bbox_top - 16 - currentStretchAmount, bbox_right - 7 + xSpeed, bbox_bottom - 17 - currentStretchAmount, o_Collision, false, false)
	{
		var pixelCheckX = sign(xSpeed);
		while !collision_rectangle(bbox_left + 7 + pixelCheckX, bbox_top - 16 - currentStretchAmount, bbox_right - 7 + pixelCheckX, bbox_bottom - 17 - currentStretchAmount, o_Collision, false, false)
		{
			x += pixelCheckX;
		}
		xSpeed = 0;
	}
}

function FloorCheck()
{
	if place_meeting(x, y + ySpeed, o_Collision) //If there is a floor in the player's path
	{
		//move player as close to floor as possible
		var pixelCheckY = sign(ySpeed)
		while !place_meeting(x, y + pixelCheckY, o_Collision)
		{
			y += pixelCheckY;
		}
		//Prevent player from passing through it
		ySpeed = 0;
	}
}

function CeilingCheck()
{
	if collision_point(x - 4, GetTopOfHead() - 1, o_Collision, false, false) || collision_point(x + 4, GetTopOfHead() - 1, o_Collision, false, false)
	{
		canStretch = false;
		if collision_point(x - 7, GetTopOfHead() - 1, o_Collision, false, false) && collision_point(x + 7, GetTopOfHead() - 1, o_Collision, false, false)
		{
			if !currentlyPulling
			{
				currentlyPulling = true;
				gravityScale = 0;
				time_source_start(PullToCeilingTimer);
			}
		}
	}
	else
	{
		canStretch = true;
	}
}

#endregion

#region Stretch

function StretchCheck()
{
	var desiredStretchDirection = stretchUpKey - stretchDownKey;
	switch(desiredStretchDirection)
	{
		case -1:
			PerformRetract();
		break;
		case 0:
			//Stay
		break;
		case 1:
			PerformStretch();
		break;
	}
}

function PerformStretch()
{
	if canStretch
	{
		currentStretchAmount = clamp(currentStretchAmount + stretchSpeed, 0, maxStretchAmount);
		if currentStretchAmount == maxStretchAmount 
		{
			//StopStretch
		}

	}
}

function PerformRetract()
{
	currentStretchAmount = clamp(currentStretchAmount - retractSpeed, 0, maxStretchAmount);
	if currentStretchAmount == 0
	{
		//stop retracting
	}
}

PullToCeiling = function()
{
	currentStretchAmount -= 1;
	y -= 1;
	if(currentStretchAmount == 0)
	{
		time_source_reset(PullToCeilingTimer);

	}
}

PullToCeilingTimer = time_source_create(time_source_game, 1, time_source_units_frames, PullToCeiling, [], -1);



#endregion

#endregion