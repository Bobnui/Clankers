image_speed=0;
function EndGame()
{
	var lay_id = layer_get_id("Robot");
	layer_set_visible(lay_id, false);
	image_speed = 1
	O_Player.moveSpeed=0
	O_Player.canStretch=false
	O_Player.canExtend=false
	O_Player.canHover=false
	O_Player.canLaser=false
	O_Player.canAttach=false
	O_Player.canMoveWhileStretching=false
}
