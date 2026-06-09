enum PickUpType
{
	Stretch,
	Hover,
	Lazer,
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
			O_Player.currentStretchPickUp ++;
			if O_Player.currentStretchPickUp == O_Player.maxStretchPickUp
			{
				O_Player.stretchUnlocked = true
				show_message("Stretch Unlocked");
			}
		break;
		
		case PickUpType.Hover:
			O_Player.currentHoverPickUp ++;
			if O_Player.currentHoverPickUp == O_Player.maxHoverPickUp
			{
				O_Player.hoverUnlocked = true;
				show_message("Hover Unlocked");
			}
		break;
		
		case PickUpType.Lazer:
			O_Player.currentLazerPickUp ++;
			if O_Player.currentLazerPickUp == O_Player.maxLazerPickUp
			{
				O_Player.lazerUnlocked = true;
				show_message("Lazer Unlocked");
			}
		break;
		
		case PickUpType.ExtendoArm:
			O_Player.currentExtendoArmPickUp ++;
			if O_Player.currentExtendoArmPickUp == O_Player.maxExtendoArmPickUp
			{
				O_Player.extendoArmUnlocked = true;
				show_message("ExtendoArm Unlocked");
			}
		break;
		
		case PickUpType.SuperFunHappySlide:
			O_Player.currentSuperFunHappySlidePickUp ++;
			if O_Player.currentSuperFunHappySlidePickUp == O_Player.maxSuperFunHappySlidePickUp
			{
				O_Player.superFunHappySlideUnlocked = true;
				show_message("superFunHappySlide Unlocked");
			}
		break;
		
		case PickUpType.Collectable:
			O_RoomManager.CollectableCount ++;
			show_debug_message(O_RoomManager.CollectableCount);
		break;
	}
}

