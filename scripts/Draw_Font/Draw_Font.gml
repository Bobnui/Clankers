function Draw_Font(_text, _x, _y, _centered, scale)
{
	var _start_x;
	
	if _centered == true
	{
		_start_x = _x - ((string_length(_text) * O_UIManager.font_width) * .5); // find the start point for centered text
	}
	else
	{
		_start_x = _x; // the start point for left-justified text is just the normal x.		
	}
	
	var _ch;
	for (_ch = 0; _ch < string_length(_text); _ch++)
	{
		var _index = string_pos(string_char_at(_text, _ch + 1), font_letters) - 1;
		draw_sprite_ext(s_UI_Font, _index, _start_x + (_ch * O_UIManager.font_width), _y, scale, scale, 0, c_white, 1);
	}	
}