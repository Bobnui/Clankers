function Spawn_Particles()
{
	var _p;
	for (_p = 0; _p < 4; _p++)
	{
		particle = instance_create_layer(x, y - 5, "Particle_Layer", o_Particle);
		particle.h_speed = choose(-3, 3); // left or right?
		particle.v_speed = (random(.5) - .25) // between -.25 and .25
	}
	audio_play_sound(snd_Clang, 1, false, 1, 0, 1 + (random(.05) - .025));

}