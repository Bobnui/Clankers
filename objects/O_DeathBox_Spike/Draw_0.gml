draw_self();

spikesToDraw = round(image_xscale);



for (var i = 1; i < spikesToDraw; i += 1)
{
	draw_sprite_ext(S_Spike, 0, x + ((i - 1) * 10), y, 1, image_yscale, 0, c_white, 1); 
}