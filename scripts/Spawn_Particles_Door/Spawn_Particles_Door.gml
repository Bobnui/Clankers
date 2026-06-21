function DoorParticles()
{
	particles = part_system_create(PS_Door)
	if image_xscale>0
		{
			part_system_position(particles, x + O_Player.currentLaserLength, y-20);
			part_system_drawit(particles);
		}
		else if image_xscale<0
		{
			part_system_position(particles, x - O_Player.currentLaserLength, y-20);
			part_system_drawit(particles);
		}
}