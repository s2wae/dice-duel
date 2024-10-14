extends Node


var curScene = null
var curBoard = null
var curBench
var curDice
var dCounter = 0
var benchCounter = 0
var goldCount = 30
var isDragging = false
var curMouseState = mouseState.RELEASED

enum slotState {
	FREE, USED
}

enum mouseState {
	DOWN, RELEASED
}

func _ready():
	var root = get_tree().root
	curScene = root.get_child(root.get_child_count() - 1)


func goto_scene(path):
	_deferred_goto_scene.call_deferred(path)


func _deferred_goto_scene(path):
	curScene.free()
	var p = ResourceLoader.load(path)
	curScene = p.instantiate()
	get_tree().root.add_child(curScene)
	get_tree().current_scene = curScene




