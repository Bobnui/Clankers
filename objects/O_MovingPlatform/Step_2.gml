x += moveX; // Add movex/y to x/y values of the platform instance so it moves
y += moveY;

// check if it's at start position
if (goingToStart && point_distance(x,y, startX, startY) < currentSpeed) { // check if platform is heading to start, then if the distance between current position and start is less than the current speed it means the start is close
	goingToStart = false; // set goingToStart to false
	currentSpeed = 0;
	alarm[0] = waitTime;
}

// check if it's at end position
else if (!goingToStart && point_distance(x,y, startX, startY) < currentSpeed) { // check if platform is heading to start, then if the distance between current position and start is less than the current speed it means the start is close
	goingToStart = true; // set goingToStart to true
	currentSpeed = 0;
	alarm[0] = waitTime;
}