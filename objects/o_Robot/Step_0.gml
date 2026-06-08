if o_Game.pause == false
{

	// reset some variable each frame:

	h_speed = 0;
	rising = false;
	rise_direction = 0;
	image_speed = 0;

	// CODE FOR ROLLING AROUND ON THE GROUND:

	if hanging == false
	{
		torso_sprite = 0;
	
		// ARE WE PRESSING SPACE?
	
		if keyboard_check(vk_space) && no_ceiling == false && no_space == false
		{
			audio_stop_sound(snd_Air);
			rise_amount += 1; // if so, increase the middle bit
			rise_direction = -1; // going up
		}
		else
		{
			if rise_amount > 0 // no space pressed, but if we're still tall:
			{
				if rise_amount > 1
				{
					rise_amount -= 2;	// collapse quickly
				}
				else
				{
					rise_amount -= 1; // but only if you're higher than 2 pixels
				}
				rise_direction = 1;
				if rise_amount == 0
				{
					Spawn_Particles();	
					no_ceiling = false;
				}
			}
		}


		if rise_amount > 0
		{
			rising = true;	
		}

		// TESETING FOR LEFT AND RIGHT KEY PRESS - we can only move left/right if we aren't tall:

		if rising == false
		{
			if keyboard_check(ord("A"))
			{
				h_speed -= 1;	
			}

			if keyboard_check(ord("D"))
			{
				h_speed += 1;
			}

			if abs(h_speed) > 0 // if we are moving left or right:
			{
				image_xscale = h_speed; // flip the sprite!
				image_speed = 1; // animate the wheels
			}
		}
		else // THIS BIT CHANGES THE TORSO SPRITE FOR CUTE UP/DOWN MOVEMENT
		{
			if rise_direction == -1
			{
				torso_sprite = 1; // going up sprite
			}
			else
			{
				torso_sprite = 2; // going down sprite
			}
		}


		// Finally move the robot left/right (check for collisions etc):

		if abs(h_speed) > 0
		{
			if !place_meeting(x + h_speed, y - 1, O_Collision) // not heading into a wall?
			{
				if collision_point(x + (4 * h_speed), y, O_Collision, false, false) // is there ground below?
				{
					x += h_speed; // move the robot along
			
					// make a sound:
					if !audio_is_playing(snd_Wheels)
					{				
						audio_play_sound(snd_Wheels, 1, true);	
						motor = audio_play_sound(snd_Motor, 1, false, 1, 0, .9);
					}
				}
				else // Not very good coding structure all IF-ELSE statements, but it does work!
				{
					image_speed = 0; // stop the animation
					audio_stop_sound(snd_Wheels);
					audio_stop_sound(snd_Motor);
				}
			}
			else
			{
				image_speed = 0	// stop the animation
				audio_stop_sound(snd_Wheels);
				audio_stop_sound(snd_Motor);
			}
		}
		else
		{
			audio_stop_sound(snd_Wheels);
			audio_stop_sound(snd_Motor);	
		}
	


		// this bit speeds up the motor sound (fancy):

		if audio_is_playing(snd_Motor)
		{
			if audio_sound_get_pitch(motor) < 1
			{
				audio_sound_pitch(motor, audio_sound_get_pitch(motor) * 1.005);
			}
		}

		if rising == true
		{
			if rise_direction == -1 // ARE WE GOING UP?
			{
				if !audio_is_playing(snd_Extend)
				{
					rise = audio_play_sound(snd_Extend, 1, false);
				}
			
				// CHECK FOR THE CEILING:
			
				if collision_point(x - 4, y - rise_amount - 13, o_Ceiling, false, false) && collision_point(x + 4, y - rise_amount - 13, o_Ceiling, false, false)
				{
					audio_play_sound(snd_Hit, 1, false, 1, 0, .8);
					hanging = true;
					from_the_ground = true;
				}
				else if collision_point(x - 4, y - rise_amount - 13, o_Ceiling, false, false) || collision_point(x + 4, y - rise_amount - 13, o_Ceiling, false, false)
				{
					no_ceiling = true; // IF THERE'S ONLY A PARTIAL CEILING, RETURN TO THE GROUND!
					no_space = true;
				}
			}
			else
			{
				audio_stop_sound(snd_Extend);
			
				if !audio_is_playing(snd_Air)
				{
					audio_play_sound(snd_Air, 1, false);
				}
			}
		}
		else
		{
			audio_stop_sound(snd_Extend);
			audio_stop_sound(snd_Air);
		}
	}

	/////////// CODE FOR MOVING ALONG THE CEILING:

	else
	{
		if rise_amount > 0 // This bit retracts your body when you first arrive on the ceiling:
		{
			audio_sound_pitch(rise, 1.1);
			y -= 2;
			rise_amount -= 2;
			if rise_amount == 0
			{
				audio_stop_sound(snd_Extend);
				audio_stop_sound(snd_Air);
				Spawn_Particles();
			}
		}
		else
		{
			if keyboard_check(vk_space) && from_the_ground == false && no_space == false // is the player trying to go back down?
			{
				audio_stop_sound(snd_Air);
				if collision_point(x - 3, y, O_Collision, false, false) && collision_point(x + 3, y, O_Collision, false, false)
				{
					no_space = true;
					hanging = false;
					rise_amount = lowering_amount;
					rise_direction = -1;
					rising = false;
					lowering_amount = 0;
					audio_play_sound(snd_Hit, 1, false, 1, 0, .6);
				}
				else if collision_point(x - 3, y, O_Collision, false, false) || collision_point(x + 3, y, O_Collision, false, false)
				{
					audio_play_sound(snd_Air, 1, false);
					lowering_direction = -1;
					no_space = true;
				}
				else
				{
					if !audio_is_playing(snd_Extend)
					{
						rise = audio_play_sound(snd_Extend, 1, false);
					}
					if lowering_amount < extend_limit
					{
						y += 1;
						lowering_amount += 1;
						lowering_direction = 1;
					}
					else
					{
						lowering_direction = -1;
						no_space = true;
						audio_play_sound(snd_Air, 1, false);
					}
				}
			}
			else // Body is being dragged back up again:
			{
				audio_sound_pitch(rise, 1.1);
			
				if lowering_amount > 0
				{
					if !audio_is_playing(snd_Air)
					{
						audio_play_sound(snd_Air, 1, false);
					}
				
					var _l = 0;
				
					if lowering_amount > 2
					{
						_l = 2;
					}
					else 
					{
						_l = 1;
					}
				
					lowering_amount -= _l;
					y -= _l;
				
					lowering_direction = 1;
				
					if lowering_amount == 0 // Have we finished?
					{
						Spawn_Particles(); // Clang!
						audio_stop_sound(snd_Air);
						audio_stop_sound(snd_Extend);
					}
				}
			}
		
			if lowering_amount == 0 // if not, check for left/right key presses:
			{
				if keyboard_check(ord("A"))
				{
					h_speed -= 1;	
				}

				if keyboard_check(ord("D"))
				{
					h_speed += 1;
				}
			}

			if abs(h_speed) > 0 // if we are moving left or right:
			{
				hanging_move_count ++; // this is just for animation and timed sound effects
			
				image_xscale = h_speed; // flip the sprite!
			
				if hanging_move_count mod 3 == 0
				{
					if !place_meeting(x + h_speed, y, O_Collision) && collision_point(x + (5 * h_speed), y - 13, o_Ceiling, true, false)
					{
						old_x = hanging_move_count;
						torso_sprite += 1;
						if torso_sprite > 3
						{
							torso_sprite = 0;	
						}
						if torso_sprite == 3
						{
							audio_play_sound(snd_Ceiling_1, 1, false);
						}
						if torso_sprite == 0
						{
							audio_play_sound(snd_Ceiling_2, 1, false);
						}
					
						x += h_speed; // Move the robot left or right
					}
					else
					{
						torso_sprite = 1;	
					}
				}
			}
			else
			{
				torso_sprite = 1; // "Still" frame
				hanging_move_count = 0;	
			}
		}
	}



	// the disk/pickup collision only checks use the base (wheels) of the character, 
	// so here we also check if the head is colliding with a pickup. 
	// This way, if we are stretching up, we can pick up disks:

	var _body_check = collision_point(x, y - lowering_amount - rise_amount - 8, o_Magnet, true, false);
	if _body_check != noone
	{
		Pickup(_body_check);
	}


	// restart game with ESCAPE key
	
	if keyboard_check(vk_escape)
	{
		game_restart();
	}
}
