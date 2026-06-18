//Movement Values
xSpeed = 0;
ySpeed = 0;
moveSpeed = 1;
gravityScale = .2;

//StateBools
isGrounded = true;
isCeilingAbove = false;
isHanging = false;

//Platform
platformXSpeed = 0;
platformYSpeed = 0;

//Checkpoint
currentCheckpoint = noone;
startingLocationX = x;
startingLocationY = y;

//Sprite
animFrameLength = 5; //number of frames per animation
hangingFrameCounter = 0;
hangingSpriteIndex = 0;

//Audio
motorSound = 0;
stretchSound = 0;
retractSound = 0;
playHitSound = false;

//Stretch
canStretch = true;
canAttach = false;
canExtend = true;

isStretching = false;
isRetracting = false;
isExtending = false;
isRecalling = false;

currentStretchAmount = 0;
maxStretchAmount = 100;

stretchSpeed = 1;
retractSpeed = 2;

shouldAutoRetract = true;
canMoveWhileStretching = true;

//ExtendoArms
canExtend = true

isExtending = false;
isRecalling = false;

currentExtendAmount = 0;
maxExtendAmount = 80;

extendSpeed = 1;
recallSpeed = 2;

shouldAutoRecall = true;
//Hover
canHover = true;
isHovering = false;

maxHoverTimer = 4;

//Laser
canLaser = true;

isLasering = false;
isEnding = false;

currentLaserLength = 0;
maxLaserLength = 60;

laserSpeed = 8;
endSpeed = 6;
#region FUNCTIONS

function DEBUG()
{
	//Will happen every frame before anything else
}

#region Input

function GetInput() // returns all current input values
{
	leftKey = keyboard_check(ord("A"));
	rightKey = keyboard_check(ord("D"));
	upKey = keyboard_check(ord("W"));
	downKey = keyboard_check(ord("S"));
	hoverKey = keyboard_check(vk_space);
	extendoArmKey = keyboard_check(ord("E"));
	laserEyeKey = keyboard_check(vk_shift);
}

#endregion

#region Movement

function CalculateSpeed()
{
	xSpeed = (rightKey - leftKey) * moveSpeed; //Sets xSpeed variable based on input & moveSpeed
	if !isGrounded && !isHanging && !isCeilingAbove
	{
		ySpeed += gravityScale //if the player isn't on the ground or hanging from ceiling, apply gravity
	}
	else if ySpeed > 0
	{
		ySpeed = 0; //otherwise stop them from clipping through the floor
	}
}

function ApplyMovement() //Add calculated speed to player's current position
{
	if currentStretchAmount != 0 && !canMoveWhileStretching
	{
		xSpeed = 0;
	}
	xSpeed += platformXSpeed;
	ySpeed += platformYSpeed;
	
	
	x += xSpeed;
	y += ySpeed;
}
#endregion

#region Audio

function XMoveAudio()
{
	if xSpeed != 0 && !audio_is_playing(snd_Wheels) && !isHanging // when player moves while not hanging
	{				
		audio_play_sound(snd_Wheels, 1, true, 1, 0, 0.9);	//play wheel sound
		motorSound = audio_play_sound(snd_Motor, 1, false, 1, 0, .9);	//start motor sound
	}
	else if xSpeed != 0 && isHanging //player moves while hanging
	{
		if hangingSpriteIndex == 0 && !audio_is_playing(snd_Ceiling_1)
		{
			audio_play_sound(snd_Ceiling_1, 1, false); //alternate between first 
		}
		else if hangingSpriteIndex == 2 && !audio_is_playing(snd_Ceiling_2)
		{
			audio_play_sound(snd_Ceiling_2, 1, false);	//and second ceiling sound
		}
	}
	else if xSpeed == 0 // if player stops moving
	{
		audio_stop_sound(snd_Wheels); //stop wheel
		audio_stop_sound(snd_Motor); // and motor sounds
	}
	
	if audio_is_playing(snd_Motor) // if motor sound is playing
		{
			if audio_sound_get_pitch(motorSound) < 1 //and its pitch is below 1
			{
				audio_sound_pitch(motorSound, audio_sound_get_pitch(motorSound) * 1.005); //increment its pitch
			}
		}
}

function StretchAudio()
{
	if isStretching //player is stretching 
	{
		if currentStretchAmount != maxStretchAmount //but hasn't reached max length
		{
			if !audio_is_playing(snd_Extend) // and stretchSound isn't playing atm
			{
				stretchSound = audio_play_sound(snd_Extend, 1, false); // play stretch sound
			}
		}
		else if currentStretchAmount >= maxStretchAmount //if they have reached the max stretch length
		{
			audio_stop_sound(stretchSound); // stop the stretch sound
		}
	}
	if isRetracting // player is retracting
	{
		if !audio_is_playing(snd_Air) && !isHanging // they aren't hanging & the retract sound isn't playing yet
		{
			retractSound = audio_play_sound(snd_Air, 1, false);// so play the retract sound
			audio_stop_sound(stretchSound);//and stop stretch sound
		}
		else if isHanging // or if they are hanging from the ceiling
		{
			if !audio_is_playing(stretchSound) //stretch audio stopped bc player was @ max length
			{
				stretchSound = audio_play_sound(snd_Extend, 1, false); // so start the sound again
			}
			audio_sound_pitch(stretchSound, 1.1); // increase pitch of stretch sound
		}
	}
	else // none of the above conditions are met
	{
		audio_stop_sound(retractSound); //so stop the retract sound from playing
	}
	
	if playHitSound // this bool is set when the player begins attaching to roof / ceiling and also when they finish retracting
	{
		playHitSound = false;//ensures this event doesn't repeat for more than a single frame
		if currentStretchAmount > 0 // the player is currently stretching
		{
			audio_play_sound(snd_Hit, 1, false, 1, 0, 0.8); //so play the hit sound
		}
		else // the player isn't stretching
		{
			audio_play_sound(snd_Clang, 1, false); //so play a clang sound instead
			audio_stop_sound(stretchSound); //and stop the stretch sound (which should now have a higher pitch)
		}
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
	if abs(xSpeed) != 0 && !O_PauseManager.gamePaused // If the player is currently moving
	{
		image_xscale = rightKey - leftKey; //set their sprite facing the direction they are moving
		if isGrounded
		{
			image_speed = moveSpeed * 0.5; //Animate wheels
		}
	}
	else
	{
		image_speed = 0; //Stop wheels from moving
	}
}

function UpdateHangingSprite()
{
	if abs(xSpeed) //if player is moving at all
	{
		if hangingFrameCounter < animFrameLength //checks if our sprite frame can stay as is
		{
			hangingFrameCounter ++; // if it can, increase the frame counter
		}
		else if hangingFrameCounter == animFrameLength //otherwise we have reached our frame max length
		{
			hangingFrameCounter = 0; // so we should reset the frame counter
			
			if hangingSpriteIndex == 3 //if we are currently on the final frame
			{
				hangingSpriteIndex = 0; // loop back to the first frame
			}
			else // otherwise
			{
				hangingSpriteIndex ++; //go to the next frame
			}
		}
	}
}

#endregion

#region Basic Collision

function PickUpCheck()
{
	//Torso
	var torsoCol = collision_rectangle(bbox_left + 6 + xSpeed, bbox_top - 4 - currentStretchAmount, bbox_right - 6 + xSpeed, bbox_bottom - 6, O_PickUpParent, false, false);
	if torsoCol != noone
	{
		Pickup(torsoCol, torsoCol.Type);
	}
	
	//Shoulder
	var shoulderCol = collision_rectangle(bbox_left + 4 + xSpeed, bbox_top - 9 - currentStretchAmount, bbox_right - 4 + xSpeed, bbox_bottom - 12 - currentStretchAmount, O_PickUpParent, false, false);
	if shoulderCol != noone
	{
		Pickup(shoulderCol, shoulderCol.Type);
	}
	//Head
	var headCol = collision_rectangle(bbox_left + 7 + xSpeed, bbox_top - 16 - currentStretchAmount, bbox_right - 7 + xSpeed, bbox_bottom - 17 - currentStretchAmount, O_PickUpParent, false, false);
	if headCol != noone 
	{
		Pickup(headCol, headCol.Type);
	}
}

function PlatformCheck()
{
	var onPlatform = place_meeting(x, y + 2, O_MovingPlatform) // If there is a MP directly below the player
	var underPlatform = place_meeting(x, GetHeadLocation() - 1, O_MovingPlatform)
	if onPlatform || underPlatform
	{
		platformXSpeed = O_MovingPlatform.moveX;
		platformYSpeed = O_MovingPlatform.moveY;
	}
	else
	{
		platformXSpeed = 0;
		platformYSpeed = 0;
	}
		
}

function GroundedCheck()
{
	if place_meeting(x, y + 1, O_Collision) // If there is a floor directly below the player
	{
		isGrounded = true;
	}
	else if place_meeting(x, y + ySpeed, O_Collision) //If there is a floor in the player's path
	{
		//move player as close to floor as possible
		var pixelCheckY = sign(ySpeed)
		while !place_meeting(x, y + pixelCheckY, O_Collision)
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
	//if both of the player's hands are touching the pixelYCheck
	if collision_point(x - 7, GetHeadLocation() - 1, O_Collision, false, false) && collision_point(x + 7, GetHeadLocation() - 1, O_Collision, false, false)
	{
		isCeilingAbove = true; // then we are touching the 1
		canAttach = true;
	}
	else if collision_point(x, GetHeadLocation() - 1, O_Collision, false, false) 
	|| collision_point(x + 3, GetHeadLocation() - 1, O_Collision, false, false) 
	|| collision_point(x - 3, GetHeadLocation() - 1, O_Collision, false, false)
	|| collision_point(x + 7, GetHeadLocation() - 1, O_Collision, false, false) 
	|| collision_point(x - 7, GetHeadLocation() - 1, O_Collision, false, false)
	|| collision_point(x + 10, GetHeadLocation() - 1, O_Collision, false, false) 
	|| collision_point(x - 10, GetHeadLocation() - 1, O_Collision, false, false)
	{
		isCeilingAbove = true;
		canAttach = false;
	}
	else
	{
		isCeilingAbove = false; //otherwise we aren't
		canAttach = false;
	}
	if ySpeed < 0 && place_meeting(x, GetHeadLocation() + 6 + ySpeed, O_Collision) // Stops player from flying through ceiling
	{
		var pixelYCheck = sign(ySpeed);
		while !place_meeting(x, GetHeadLocation() - pixelYCheck, O_Collision)
		{
			y += pixelYCheck;
		}
		ySpeed = 0;
	}
}

function WallCheck()
{
	
	if place_meeting(x + xSpeed, y, O_Collision) // If there is a wall where play is trying to move
	{
		//move player as close to wall as possible
		var pixelCheckX = sign(xSpeed);
		while !place_meeting(x + pixelCheckX, y, O_Collision)
		{
			x += pixelCheckX;
		}
		//Then prevent player passing through it
		xSpeed = 0;
	}
	//Repeat collision for torso
	if collision_rectangle(bbox_left + 6 + xSpeed, bbox_top - 4 - currentStretchAmount, bbox_right - 6 + xSpeed, bbox_bottom - 6, O_Collision, false, false)
	{
		var pixelCheckX = sign(xSpeed);
		while !collision_rectangle(bbox_left + 6 + xSpeed, bbox_top - 4 - currentStretchAmount, bbox_right - 6 + xSpeed, bbox_bottom - 6, O_Collision, false, false)
		{
			x += pixelCheckX;
		}
		xSpeed = 0;
	}
	
	//repeat collision for shoulders
	if collision_rectangle(bbox_left + xSpeed, bbox_top - 9 - currentStretchAmount, bbox_right + xSpeed, bbox_bottom - 12 - currentStretchAmount, O_Collision, false, false)
	{
		var pixelCheckX = sign(xSpeed);
		while !collision_rectangle(bbox_left + pixelCheckX, bbox_top - 9 - currentStretchAmount, bbox_right + pixelCheckX, bbox_bottom - 12 - currentStretchAmount, O_Collision, false, false)
		{
			x += pixelCheckX;
		}
		xSpeed = 0;
	}
	//repeat collision for head
	else if collision_rectangle(bbox_left + 7 + xSpeed, bbox_top - 16 - currentStretchAmount, bbox_right - 7 + xSpeed, bbox_bottom - 17 - currentStretchAmount, O_Collision, false, false)
	{
		var pixelCheckX = sign(xSpeed);
		while !collision_rectangle(bbox_left + 7 + pixelCheckX, bbox_top - 16 - currentStretchAmount, bbox_right - 7 + pixelCheckX, bbox_bottom - 17 - currentStretchAmount, O_Collision, false, false)
		{
			x += pixelCheckX;
		}
		xSpeed = 0;
	}
}

function HangingGapCheck()
{
	if isHanging // player is on the ceiling
	{
		// if moving would mean they cross a gap
		if !collision_point(x + 7 + xSpeed, GetHeadLocation() - 1, O_Collision, false, false) || !collision_point(x - 7 + xSpeed, GetHeadLocation() - 1, O_Collision, false, false)
		{
			xSpeed = 0; // stop them from moving
		}
	}
}

function DeathBoxCheck()
{
	if place_meeting(x, GetHeadLocation() + 6, O_DeathBoxParent)
	{
		Die();
	}
}


#endregion

#region Death

function Die()
{
	currentStretchAmount = 0;
	currentExtendAmount = 0;
	currentLaserLength = 0;
	isHanging = false;
	ySpeed = 0;
	xSpeed = 0;
	if currentCheckpoint != noone
	{
		x = currentCheckpoint.x;
		y = currentCheckpoint.y;
	} 
	else
	{
		x = startingLocationX;
		y = startingLocationY;
	}
}

#endregion

#region Stretch

#region Checks

function StretchCheck()
{
	if canStretch && !playHitSound
	{
		//Stretch Direction
		var desiredStretchDirection = upKey - downKey;
		switch(desiredStretchDirection)
		{
			case 1: //Is holding up key
				if !isHanging
				{
					PerformStretch(); // Stretch from ground
				}
				else if currentStretchAmount != 0 // prevents flying threough ceiling
				{
					PerformRetract(); // Retract from ceiling
				}
			break;
		
			case 0: // is not pressing up/down OR if pressing both up/down
				if shouldAutoRetract && currentStretchAmount > 0
				{
					PerformRetract(); // only auto retracts if shouldAutoRetract is true
				}
			break;
		
			case -1: // is holding down key
				if isHanging
				{
					PerformStretch();// Stretch from ceiling
				}
				else
				{
					PerformRetract(); // retract from ground
				}
			break;
		}
	}
}

function AttachCheck()
{
	if !isHanging && isStretching && isCeilingAbove && canAttach // if not hanging, and stretching and player hits a ceiling
	{
		playHitSound = true; // plays sound in audio function, then is set false once more
		canStretch = false; // prevents player from stretching while they attach
		isStretching = false; // they are not stretching anymore
		isHanging = true; //they are hanging now
		isRetracting = true; //they are retracting until they have fully on the ceiling
		time_source_start(AttachToCeilingTimer); //call timer, which starts a repeating event
	}
	else if isHanging && isStretching && isGrounded // if on the ceiling, and stretching and player hits the floor
	{
		playHitSound = true; // plays sound in audio function
		canStretch = false; // prevents plays from stretching
		isStretching = false; // player isn't stretching anymore
		isHanging = false; // nor are they haning
		isRetracting = true;// they are retracting until fully on the ground
		time_source_start(AttachToFloorTimer);//call timer, which starts a repeating event
	}
}

function StretchOffsetCheck()
{
	if isHanging 
	{
		if collision_point(x, GetHeadLocation(), O_Collision, false, false)
		{
			y += 1; // Prevents player clipping into ceiling
		}
		
		else if !collision_point(x, GetHeadLocation() - 1, O_Collision, false, false)
		{
			y -= 1;
		}
		
	}
	else if isGrounded && place_meeting(x, y, O_Collision)
	{
		y -= 1; // prevents player from clipping through the floor
	}
}

#endregion

#region Base Ability

function PerformStretch()
{
	audio_stop_sound(snd_Air); // stop retract audio
	isRetracting = false; 
	if canStretch
	{
		if  (isGrounded && !isCeilingAbove) || !isGrounded
		{
			currentStretchAmount = clamp(currentStretchAmount + stretchSpeed, 0, maxStretchAmount); //stops player from stretching beyond maxStrentchLength
		}
		
		if isHanging  //if hanging
		{
			y += stretchSpeed; // stretch player wheels down
		}
	}
	isStretching = true;
}

function PerformRetract()
{
	isStretching = false;
	currentStretchAmount = clamp(currentStretchAmount - retractSpeed, 0, maxStretchAmount); //stops player from retracting lower than 0
	if isHanging && currentStretchAmount > 0 //if hanging
	{
		y -= retractSpeed; //retract player wheels up
	}
	if currentStretchAmount <= 0
	{
		currentStretchAmount = 0;
		
		if isRetracting && isHanging
		{
			//y -= retractSpeed; //Fixes odd behaviour where robot would move down if retracting from ceiling
		}
		isRetracting = false;
		playHitSound = true;
	}
	else
	{
		isRetracting = true;
	}
}

#endregion

#region Timer functions

AttachToCeiling = function()
{
	currentStretchAmount -= retractSpeed; //reduce stretch length
	y -= retractSpeed; //and move wheels up the same amount
	
	if currentStretchAmount <= 0
	{
		isRetracting = false;
		playHitSound = true;
		currentStretchAmount = 0;
		time_source_reset(AttachToCeilingTimer); //stops this function from repeating
		canStretch = true; // ensures player completes this action before they can stretch again
	}
}

AttachToFloor = function()
{
	currentStretchAmount -= retractSpeed; //reduce stretch length
	
	if currentStretchAmount <= 0
	{
		currentStretchAmount = 0;
		playHitSound = true;
		isRetracting = false;
		time_source_reset(AttachToFloorTimer);//stops this function from repeating
		canStretch = true;// ensures player completes this action before they can stretch again
	}
}

AttachToCeilingTimer = time_source_create(time_source_game, 1, time_source_units_frames, AttachToCeiling, [], -1);
AttachToFloorTimer = time_source_create(time_source_game, 1, time_source_units_frames, AttachToFloor, [], -1);

#endregion

#endregion

#region Hover

function HoverCheck()
{
	if hoverKey
	{
		if !isHanging && canHover
		{
			canHover = false;
			isHovering = true;
			gravityScale = 0;
			ySpeed = 0;
			time_source_start(HoverTimer);
		}
	}	
	
	else if !hoverKey && isHovering
	{
		EndHover();
	}
	
	if isGrounded || isHanging
	{
		canHover = true;
	}
}

EndHover = function()
{
	isHovering = false;
	gravityScale = 0.2;
	time_source_stop(HoverTimer);
}

HoverTimer = time_source_create(time_source_game, maxHoverTimer, time_source_units_seconds, EndHover);

#endregion

#region Extendo Arm

function ExtendoCheck()
{
	if isGrounded && !isStretching && !isRetracting && !isHanging && !isLasering && !isEnding
	{
		//extend key pressed
		var desiredExtendDirection = extendoArmKey;
		switch(desiredExtendDirection)
		{
			case 1: //Is holding E
				if isGrounded
				{
					PerformExtend(); //extend
				}
			break;
		
			case 0: // is not pressing E
				if shouldAutoRecall && currentExtendAmount > 0
				{
					PerformRecall(); // only auto recalls if shouldAutoRecall is true
				}
			break;
		}
	}
}

function PerformExtend()
{
	isRecalling = false; 
	
	if canExtend
	{
		currentExtendAmount = clamp(currentExtendAmount + extendSpeed, 0, maxExtendAmount); //stops player from Extending beyond maxExtendLength
	}
	isExtending = true;
	if currentExtendAmount>0
	{
		moveSpeed = 0;
		canStretch = false;
		canLaser = false;
	}
}

function PerformRecall()
{
	isExtending = false;
	currentExtendAmount = clamp(currentExtendAmount - recallSpeed, 0, maxExtendAmount); //stops player from recalling through themself
	if currentExtendAmount <= 0
	{
		currentExtendAmount = 0;
		isRecalling = false;
		moveSpeed = 1;
		canStretch = true;
		canLaser = true;
	}
	else
	{
		isRecalling = true;
	}
}
//Check for a wall in the way while extending arm depending on direction faced
function ExtendoCollision()
{
	//if facing Right
	if image_xscale>0
	{
		if isExtending && place_meeting(x + currentExtendAmount+4, y+13, O_Collision) // If there is a wall where player is extending their arm max length becomes current length
		{
			maxExtendAmount = currentExtendAmount;
		}
		else
		{
			maxExtendAmount = 80; // If no wall max entend stays the same/resets
		}
		//ArmPickups
		if isExtending
		{
			var armCol = collision_rectangle(bbox_left + 6, bbox_top - 4, bbox_right + currentExtendAmount, bbox_bottom - 6, O_PickUpParent, false, false);
			if armCol != noone
			{
				Pickup(armCol, armCol.Type);
			}
		}
	}
	//if facing Left
	if image_xscale<0
	{
		if isExtending && place_meeting(x - currentExtendAmount - 4, y+13, O_Collision) // If there is a wall where player is extending their arm max length becomes current length
		{
		maxExtendAmount = currentExtendAmount;
		}
		else
		{
			maxExtendAmount = 80; // If no wall max entend stays the same/resets
		}
		//ArmPickups
		if isExtending
		{
			var armCol = collision_rectangle(bbox_left + 2 - currentExtendAmount, bbox_top - 4, bbox_right, bbox_bottom - 6, O_PickUpParent, false, false);
			if armCol != noone
			{
				Pickup(armCol, armCol.Type);
			}
		}
	}
}

#endregion

#region Lasers

function LaserEyeCheck()
{
	if isGrounded && !isStretching && !isRetracting && !isHanging && !isExtending && !isRecalling
	{
		//extend key pressed
		var desiredExtendDirection = laserEyeKey;
		switch(desiredExtendDirection)
		{
			case 1: //Is holding Shift
				if isGrounded
				{
					ShootLasers(); //ShootLaser
				}
				
			break;
		
			case 0: // is not pressing Shift
				if shouldAutoRecall && currentLaserLength > 0
				{
					EndLasers(); // only auto recalls if shouldAutoRecall is true
				}
			break;
		}
	}
}

function ShootLasers()
{
	isEnding = false; 
	
	if canLaser
	{
		currentLaserLength = clamp(currentLaserLength + laserSpeed, 0, maxLaserLength); //stops player from Lasering beyond maxLaserLength
	}
	isLasering = true;
	if currentLaserLength>0
	{
		moveSpeed = 0;
		canStretch = false;
		canExtend = false;
	}
}

function EndLasers()
{
	isLasering = false;
	currentLaserLength = clamp(currentLaserLength - endSpeed, 0, maxLaserLength); //stops player from recalling through themself
	if currentLaserLength <= 0
	{
		currentLaserLength = 0;
		isEnding = false;
		moveSpeed = 1;
		canStretch = true;
		canExtend = true;
	}
	else
	{
		isEnding = true;
	}
}
//Laser Collision
function DestructoCheck()
{
	if isLasering
	{	//Determines which way the player is facing/moving so when extending arms collision only increases in the currently faced direction
		if image_xscale>0
		{
			var LaserCol = collision_rectangle (bbox_left,bbox_top,bbox_right + 25 + currentLaserLength,bbox_bottom,O_DetructoDoor, false, false);
			if LaserCol != noone
			{
				DestructoWall(LaserCol,LaserCol.Type);
			}
		}
		else if image_xscale<0
		{
			var LaserCol = collision_rectangle (bbox_left - 25 - currentLaserLength,bbox_top,bbox_right,bbox_bottom,O_DetructoDoor, false, false);
			if LaserCol != noone
			{
				DestructoWall(LaserCol,LaserCol.Type);
			}
		}
	}
}

function LaserCollision()
{
	//if facing Right
	if image_xscale>0
	{
		if collision_point(x + currentLaserLength, y - 19, O_Collision, false, false) // If there is a wall where player is Lasering their laser max length becomes current length
		{
			var laserAss = 1;
			while !collision_point(x + laserAss, y - 19, O_Collision, false, false)
			{
				laserAss += 1;
			}
			maxLaserLength = laserAss;
		}
		else
		{
			maxLaserLength = 60; // If no wall max length stays the same/resets
		}
	}
	//if facing Left
	if image_xscale<0
	{
		if place_meeting(x+6 - currentLaserLength, y, O_Collision) // If there is a wall where player is Lasering their laser max length becomes current length
		{
			maxLaserLength = currentLaserLength;
		}
		else
		{
			maxLaserLength = 60; // If no wall max entend stays the same/resets
			maxLaserLength = 60; // If no wall max entend stays the same/resets
		}
	}
}

#endregion

#region Buttons

function ButtonCheck()
{
	if isExtending
	{	//Determines which way the player is facing/moving so when extending arms collision only increases in the currently faced direction
		if image_xscale>0
		{
			var ButtonCol = collision_rectangle (bbox_left + 6, bbox_top - 4, bbox_right + currentExtendAmount+4, bbox_bottom - 6, O_Button, false, false);
			if ButtonCol != noone
			{
				PressButton(ButtonCol,ButtonCol.Type);
				maxExtendAmount=currentExtendAmount;
			}			
			else
			{
				maxExtendAmount = 80
			}
		}
		else if image_xscale<0
		{
			var ButtonCol = collision_rectangle (bbox_left + 2 - currentExtendAmount-4, bbox_top - 4, bbox_right, bbox_bottom - 6,O_Button, false, false);
			if ButtonCol != noone
			{
				PressButton(ButtonCol,ButtonCol.Type);
			}
		}
	}
}

#endregion

#endregion