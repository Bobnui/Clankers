ControlSprites = [0, S_Hold_Space]

DisplaySprite = array_get_index(ControlSprites, Unlock_Number);

object_set_sprite(object_index, DisplaySprite);

show_message(object_index)
