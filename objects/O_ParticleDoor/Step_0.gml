image_alpha -= .2;

x += h_speed;
y += v_speed;


if image_alpha < 0
{
	instance_destroy();	
}