extends Node



var curScene = null
var curBench
var curDice
var isDragging = false
var curMouseState = mouseState.RELEASED
var b1
var b2
var hostBoard: GridContainer
var clientBoard: GridContainer
var oldHostBoard: GridContainer = hostBoard
var oldClientBoard: GridContainer = clientBoard
var readyCount = 0
var READY_FIGHT = false
var battleCam



enum slotState {
	FREE, USED
}

enum mouseState {
	DOWN, RELEASED
}

func _ready():
	var root = get_tree().root
	curScene = root.get_child(root.get_child_count() - 1)

func _process(delta):
	if oldHostBoard != hostBoard:
		if multiplayer.is_server():
			print("SERVER HOST CHANGED")
		else:
			print("CLIENT HOST CHANGED")
		oldHostBoard = hostBoard
		b1 = hostBoard
		
	if oldClientBoard !=  clientBoard:
		if multiplayer.is_server():
			print("SERVER CLIENT CHANGED")
		else:
			print("CLIENT CLIENT CHANGED")
		oldClientBoard = clientBoard
		b2 = clientBoard


func goto_scene(path):
	_deferred_goto_scene.call_deferred(path)


func _deferred_goto_scene(path):
	curScene.free()
	var p = ResourceLoader.load(path)
	curScene = p.instantiate()
	get_tree().root.add_child(curScene)
	get_tree().current_scene = curScene




