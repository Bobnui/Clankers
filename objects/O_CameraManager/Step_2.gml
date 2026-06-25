if finished=false
{
	camera_set_view_pos(view_camera[0], O_Player.x - 120, O_Player.y - 78 - (O_Player.currentStretchAmount * .5));
}

else if finished=true
{
	camera_set_view_pos(view_camera[0], O_EndAnim.x+3, O_EndAnim.y+80);
	camera_set_view_size(view_camera[0], view_wport[1], view_hport[1])
}