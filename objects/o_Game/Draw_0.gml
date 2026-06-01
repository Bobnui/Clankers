var cam_x = camera_get_view_x(view_camera[0]); // get the current camera position
var cam_y = camera_get_view_y(view_camera[0]);



draw_sprite(s_Border, 0, cam_x, cam_y); // draw the border

draw_sprite(s_Disk_UI, 0, cam_x + 16, cam_y + 7); // draw the blue floppy disk

Draw_Font("CLANKERS", cam_x + (240 * .5), cam_y + 7, true);

var _level = string(current_level);
if current_level < 10
{
	_level = "0" + _level;
	
}

var _level_text = "LEVEL " + _level;
Draw_Font(_level_text, cam_x + 180, cam_y + 7, false);


// draw the pickup score text:

var _number_text = string(pickup_score); // turn the score into text

if pickup_score < 10
{
	_number_text = "0" + _number_text; // add a zero before it's less than 10 to make it look cooler
}

Draw_Font(_number_text, cam_x + 25, cam_y + 7, false); // draw it (not centered)
