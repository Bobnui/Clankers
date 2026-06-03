//The create event happens whenever the object is created, including when a level is started
//It can be used like a header file to init variables

//Input values
xInput = 0;

//Movement float values
moveSpeed = 1;
gravityScale = 1;

//Player State
enum playerStates
{
	idle, // 0
	walking, // 1
	grounded, //2
	hanging, //3
	falling, // 4
	stretching, //5
	hovering, // 6
}

currentStates = [];

event_user(0) //Init State Machine

//CHARCTER SIZE
charSizeX = 

//STRETCH
canStretch = false;
currentStretchAmount = 0;
maxStretchLength = 80;

event_user(1) //Enables Stretch ability - REMOVE

//HOVER
canHover = false;
maxHoverLength = 4;

event_user(2) //Enables hover ability - REMOVE

//


