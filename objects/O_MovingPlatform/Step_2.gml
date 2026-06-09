x += moveX;																		// Add movex/y to x/y values of the platform instance so it moves
y += moveY;

																				// check if it's at start position
if (goingToStart && point_distance(x,y, startX, startY) < currentSpeed) {		// check if platform is heading to start, then if the distance between current position and start is less than the current speed it means the start is close
	goingToStart = false;														// set goingToStart to false
	currentSpeed = 0;															// set speed to 0 so the platform stops
	alarm[0] = waitTime;														// this alarm[0] will let the platform move after its waited
}

																				// check if it's at end position
else if (!goingToStart && point_distance(x,y, endX, endY) < currentSpeed) { // check if platform is heading to end, then if the distance between current position and end is less than the current speed it means the end is close
	goingToStart = true;														// set goingToStart to true
	currentSpeed = 0;
	alarm[0] = waitTime;
}