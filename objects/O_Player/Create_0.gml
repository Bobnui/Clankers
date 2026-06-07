//Movement Values
xSpeed = 0;
ySpeed = 0;
moveSpeed = 1;
gravityScale = .2;

//StateBools
isGrounded = true;
isCeilingAbove = false;
isHanging = false;
isStretching = false;
isRetracting = false;

//Unlocks
stretchUnlocked = true;
hoverUnlocked = true;

//Stretch
canStretch = true;

currentStretchAmount = 0;
maxStretchAmount = 60;

stretchSpeed = 1;
retractSpeed = 2;

shouldAutoRetract = true;
canMoveWhileStretching = false;

//Hover
isHovering = false;


#region FUNCTIONS

#region Input
function GetInput() // returns all current input values
{
	leftKey = keyboard_check(ord("A"));
	rightKey = keyboard_check(ord("D"));
	upKey = keyboard_check(ord("W"));
	downKey = keyboard_check(ord("S"));
	hoverKey = keyboard_check(vk_space);
	extendoArmKey = keyboard_check_pressed(ord("E"))
}
#endregion

#region Movement

function CalculateSpeed()
{
	xSpeed = (rightKey - leftKey) * moveSpeed; //Sets xSpeed variable based on input & moveSpeed
	if !isGrounded && !isHanging
	{
		ySpeed += gravityScale //if the player isn't on the ground or hanging from ceiling, apply gravity
	}
	else
	{
		ySpeed = 0; //otherwise stop them from clipping through the floor
	}
}

function ApplyMovement() //Add calculated speed to player's current position
{
	if currentStretchAmount == 0 || canMoveWhileStretching == true
	{
		x += xSpeed;	
	}
	if !isHovering
	{
		y += ySpeed;	
	}
}
#endregion

#region Sprite

function GetHeadLocation()
{
	return y - currentStretchAmount - 22; // This should always return the pixel at the top / center of the head
}

function SetSpriteDirection()
{
	if rightKey - leftKey != 0 // If the player is currently moving
	{
		image_xscale = rightKey - leftKey; //set their sprite facing the direction they are moving
		image_speed = moveSpeed * 0.5; //Animate wheels
	}
	else
	{
		image_speed = 0; //Stop wheels from moving
	}
}

#endregion

#region Basic Collision

function GroundedCheck()
{
	if place_meeting(x, y + 1, o_Collision) // If there is a floor directly below the player
	{
		isGrounded = true;
	}
	else if place_meeting(x, y + ySpeed, o_Collision) //If there is a floor in the player's path
	{
		//move player as close to floor as possible
		var pixelCheckY = sign(ySpeed)
		while !place_meeting(x, y + pixelCheckY, o_Collision)
		{
			y += pixelCheckY;
		}
		//Prevent player from passing through it
		ySpeed = 0;
		isGrounded = true;
	}
	else 
	{
		isGrounded = false;
	}
}

function CeilingCheck()
{
	if collision_point(x - 4, GetHeadLocation() - 1, o_Collision, false, false) && collision_point(x + 4, GetHeadLocation() - 1, o_Collision, false, false)
	{
		isCeilingAbove = true;
	}
	else
	{
		isCeilingAbove = false;
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

#endregion

#region Stretch

function StretchCheck()
{
	var desiredStretchDirection = upKey - downKey;
	switch(desiredStretchDirection)
	{
		case 1: //Is holding up key
			if !isHanging
			{
				PerformStretch();
			}
			else
			{
				PerformRetract();
			}
		break;
		
		case 0: // is not pressing up/down OR if pressing both up/down
			if shouldAutoRetract && currentStretchAmount > 0
			{
				PerformRetract();
			}
		break;
		
		case -1: // is holding down key
			if isHanging
			{
				PerformStretch();
			}
			else
			{
				PerformRetract();
			}
		break;
	}
}

function PerformStretch()
{
	isRetracting = false;
	currentStretchAmount = clamp(currentStretchAmount + stretchSpeed, 0, maxStretchAmount);
	if currentStretchAmount == maxStretchAmount 
	{
		isStretching = false;
	}
	else
	{
		isStretching = true;
	}
}

function PerformRetract()
{
	isStretching = false;
	currentStretchAmount = clamp(currentStretchAmount - retractSpeed, 0, maxStretchAmount);
	if currentStretchAmount == 0
	{
		isRetracting = false;
	}
	else
	{
		isRetracting = true;
	}
}


#endregion

#endregion