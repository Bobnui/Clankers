//Tells engine that this event will handle drawing sprites
draw_self()

//Torso Select
if isStretching
{
	draw_sprite_ext(S_Player_Torso, 1, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
}
else if isRetracting
{
	draw_sprite_ext(S_Player_Torso, 2, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
}
else if isGrounded
{
	draw_sprite_ext(S_Player_Torso, 0, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
}
else if isHanging
{
	draw_sprite_ext(S_Player_Hanging, 0, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
}
else 
{
	draw_sprite_ext(S_Player_Torso, 1, x, GetHeadLocation(), image_xscale, 1, 0, c_white, 1);
}

//Stretch midriff
draw_sprite_ext(S_Player_Midriff, 0, x, y - 10, image_xscale, currentStretchAmount, 0, c_white, 1);

//DEBUG

draw_sprite(S_DEBUG, 0, x - 7, GetHeadLocation());
draw_sprite(S_DEBUG, 0, x + 7, GetHeadLocation());
draw_set_colour(c_blue);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
draw_rectangle(bbox_left + 6 + xSpeed, bbox_top - 4 - currentStretchAmount, bbox_right - 6 + xSpeed, bbox_bottom - 6, true);
draw_rectangle(bbox_left + 4 + xSpeed, bbox_top - 9 - currentStretchAmount, bbox_right - 4 + xSpeed, bbox_bottom - 12 - currentStretchAmount, true);
draw_rectangle(bbox_left + 7 + xSpeed, bbox_top - 16 - currentStretchAmount, bbox_right - 8 + xSpeed, bbox_bottom - 17 - currentStretchAmount, true);
