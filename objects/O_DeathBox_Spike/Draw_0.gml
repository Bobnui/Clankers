draw_self();

draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);

spikesToDraw = round(image_xscale);

for (var i = 1; i < spikesToDraw + 1; i += 1)
{
	draw_sprite_ext(S_Spike, 0, x + ((i - 1) * 10), y, 1, image_yscale, 0, c_white, 1); 
}