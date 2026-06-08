var _targetX = endX, _targetY = endY; // create local variable for target position, by default set to end coord
if (goingToStart) { // changing target position to start coord
	_targetX = startX; 
	_targetY = startY;
}

// sign gives you 1 if value is positive and -1 if negative, otherwise 0
moveX = sign(_targetX - x) * currentSpeed; // calculate sign of difference between target and current position, then multiply by current speed and apply to movex/y
moveY = sign(_targetY - y) * currentSpeed;