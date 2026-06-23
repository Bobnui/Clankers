//Tells engine that this event will handle drawing sprites
draw_self()

#region Torso

if !isStretching && !isRetracting && !isExtending && !isRecalling// Not stretching or retracting or Extending arms
{
	if isGrounded
	{
		draw_sprite_ext(S_Player_Torso, 0, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
	}
	else if isHanging
	{
		draw_sprite_ext(S_Player_Hanging, hangingSpriteIndex, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
	}
	else  // falling
	{
		draw_sprite_ext(S_Player_Torso, 2, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
	}
}
else if isStretching
{
	if isHanging
	{
		draw_sprite_ext(S_Player_stretch_down,hangingSpriteIndex, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
	}
	else
	{
		draw_sprite_ext(S_Player_Torso, 1, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
	}
}
else if isRetracting
{
	if isHanging
	{
		draw_sprite_ext(S_Player_Hanging, hangingSpriteIndex, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
	}
	else
	{
		draw_sprite_ext(S_Player_Torso, 2, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
	}
}
else if isExtending || isRecalling
{
	draw_sprite_ext(S_Player_Torso, 3, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
}
#endregion

//Stretch midriff
draw_sprite_ext(S_Player_Midriff, 0, x, y - 10, image_xscale, currentStretchAmount, 0, c_white, 1);


if image_xscale>0
{	//Extend arm based on direction facing
	draw_sprite_ext(S_Player_Arm,0,x+8,y-13,currentExtendAmount,image_yscale,0, c_white, 1);
	//Shoot Lasers based on direction facing
	draw_sprite_ext(S_Laser,0,x-1,y-19,currentLaserLength,image_yscale,0, c_white, 1);
	draw_sprite_ext(S_Laser,0,x-1,y-20,currentLaserLength,image_yscale,0, c_white, 1);
	if isExtending || isRecalling
	{
		draw_sprite_ext(S_Player_Hand,0,x-2+currentExtendAmount,y-26,image_xscale,image_yscale,0, c_white, 1);
	}
	
}
else if image_xscale<0
{	//Extend arm based on direction facing
	draw_sprite_ext(S_Player_Arm,0,x-8-currentExtendAmount,y-13,currentExtendAmount,image_yscale,0, c_white, 1);
	//Shoot Lasers based on direction facing
	draw_sprite_ext(S_Laser,0,x+1-currentLaserLength,y-19,currentLaserLength,image_yscale,0, c_white, 1);
	draw_sprite_ext(S_Laser,0,x+1-currentLaserLength,y-20,currentLaserLength,image_yscale,0, c_white, 1);
	if isExtending || isRecalling
	{
		draw_sprite_ext(S_Player_Hand,0,x+2-currentExtendAmount,y-26,image_xscale,image_yscale,0, c_white, 1);
	}
}

//DEBUG
//Euan** This is how to draw_rectangle(bbox_left + xSpeed, bbox_top - 9, bbox_right-1 + xSpeed, bbox_bottom - 11, true)

//draw_sprite(S_DEBUG, 0, x + currentLaserLength, y - 19);
/*

draw_sprite(S_DEBUG, 0, x, GetHeadLocation() + ySpeed);
draw_sprite(S_DEBUG, 0, x + 3, GetHeadLocation() - 1);
draw_sprite(S_DEBUG, 0, x - 3, GetHeadLocation() - 1);
draw_sprite(S_DEBUG, 0, x + 7, GetHeadLocation() - 1);
draw_sprite(S_DEBUG, 0, x - 7, GetHeadLocation() - 1);
draw_sprite(S_DEBUG, 0, x + 10, GetHeadLocation() - 1);
draw_sprite(S_DEBUG, 0, x - 10, GetHeadLocation() - 1);
