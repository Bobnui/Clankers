if (clicked) 
{
	image_index = 1;
	//show_debug_message("Here")
	clicked = false
	instance_destroy()
	room_goto_next()
} 
else 
{
	image_index = 0;
} 
if hovering == true
{
	image_index = 1
}