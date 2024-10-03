extends Node

enum slotState{
	FREE, USED
}

enum mouseState{
	DOWN, RELEASED
}

var isDragging = false
var curMouseState = mouseState.RELEASED
