extends Node

enum slotState{
	FREE, USED
}

enum mouseState{
	DOWN, RELEASED
}

var dCounter = 0
var benchCounter = 0
var goldCount = 20
var isDragging = false
var curMouseState = mouseState.RELEASED
