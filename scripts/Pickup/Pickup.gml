enum PickUpType
{
	Stretch,
	Hover,
	Laser,
	ExtendoArm,
	SuperFunHappySlide,
	Collectable
}

function Pickup(_instance, PickUpType)
{
	instance_destroy(_instance);
	audio_play_sound(snd_Pickup, 1, false, 1, 0, 1 + (random(.1) - .05));
	
	switch PickUpType
	{
		case PickUpType.Stretch:
			O_PickUpsManager.currentStretchPickUp ++;
			if O_PickUpsManager.currentStretchPickUp == O_PickUpsManager.maxStretchPickUp
			{
				O_PickUpsManager.stretchUnlocked = true
				//show_message("Stretch Unlocked");
				O_PauseManager.gamePaused = true
				instance_create_layer(O_Player.x,O_Player.y-10,"Notifications",o_Stretch_Notification)
			}
		break;
		
		case PickUpType.Hover:
			O_PickUpsManager.currentHoverPickUp ++;
			if O_PickUpsManager.currentHoverPickUp == O_PickUpsManager.maxHoverPickUp
			{
				O_PickUpsManager.hoverUnlocked = true;
				//show_message("Hover Unlocked");
				O_PauseManager.gamePaused = true
				instance_create_layer(O_Player.x,O_Player.y-10,"Notifications",o_Hover_Notification)
			}
		break;
		
		case PickUpType.Laser:
			O_PickUpsManager.currentLaserPickUp ++;
			if O_PickUpsManager.currentLaserPickUp == O_PickUpsManager.maxLaserPickUp
			{
				O_PickUpsManager.laserUnlocked = true;
				//show_message("Laser Unlocked");
				O_PauseManager.gamePaused = true
				instance_create_layer(O_Player.x,O_Player.y-10,"Notifications",o_Lasers_Notification)
			}
		break;
		
		case PickUpType.ExtendoArm:
			O_PickUpsManager.currentExtendoArmPickUp ++;
			if O_PickUpsManager.currentExtendoArmPickUp == O_PickUpsManager.maxExtendoArmPickUp
			{
				O_PickUpsManager.extendoArmUnlocked = true;
				//show_message("ExtendoArm Unlocked");
				O_PauseManager.gamePaused = true
				instance_create_layer(O_Player.x,O_Player.y-10,"Notifications",o_Arms_Notification)
			}
		break;
		
		case PickUpType.SuperFunHappySlide:
			O_PickUpsManager.currentSuperFunHappySlidePickUp ++;
			if O_PickUpsManager.currentSuperFunHappySlidePickUp == O_PickUpsManager.maxSuperFunHappySlidePickUp
			{
				O_PickUpsManager.superFunHappySlideUnlocked = true;
				show_message("superFunHappySlide Unlocked");
			}
		break;
		
		case PickUpType.Collectable:
			O_PickUpsManager.CollectableCount ++;
			show_debug_message(O_PickUpsManager.CollectableCount);
		break;
	}
}

