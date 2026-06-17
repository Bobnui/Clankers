if (clicked) 
{
	image_index = 1;
	show_debug_message("Here")
	clicked = false
	instance_destroy()
	instance_destroy(Box)
	O_PauseManager.gamePaused = false
} 
else 
{
	image_index = 0;
} 
if hovering == true
{
	image_index = 1
}