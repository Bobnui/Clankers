// draw the wheels:

draw_self();


// draw the torso:

if hanging == false
{
	draw_sprite_ext(S_Player_Torso, torso_sprite, x, y - rise_amount - lowering_amount, image_xscale, 1, 0, c_white, 1);
}
else
{
	draw_sprite_ext(s_Robot_Torso_Hanging, torso_sprite, x, y - rise_amount - lowering_amount, image_xscale, 1, 0, c_white, 1);
}


// draw the extending middle bit:

if (rise_amount > 0) || (lowering_amount > 0)
{
	draw_sprite_ext(S_Player_Midriff, 0, x, y - 5, image_xscale, rise_amount + lowering_amount, 0, c_white, 1);
}

//draw_text(20, 20, lowering_amount);