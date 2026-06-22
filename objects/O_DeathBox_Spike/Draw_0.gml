draw_self();

//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);


spikesToDraw = round(image_xscale); // the red sprite size is the same as the spike
//so the x scale defines how many we should draw

for (var i = 1; i < spikesToDraw + 1; i += 1)//for each spike we should sraw
{
	draw_sprite_ext(S_Spike, 0, x + ((i - 1) * 10), y, 1, image_yscale, 0, c_white, 1); //draw it
}