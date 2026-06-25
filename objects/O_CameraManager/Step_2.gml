if finished=false
{
	camera_set_view_pos(view_camera[0], O_Player.x - 120, O_Player.y - 78 - (O_Player.currentStretchAmount * .5));
}
else if 
{
	camera_set_view_pos(view_camera[0], O_EndAnim.x - 120, O_EndAnim.y - 78);
}