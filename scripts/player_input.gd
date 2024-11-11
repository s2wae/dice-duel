extends MultiplayerSynchronizer

class_name PlayerInput

@export var clicking = false
@export var mousePos : Vector2

func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


func _process(delta):
	if Input.is_action_just_pressed("lmb"):
		mousePos = get_viewport().get_mouse_position()
		GameManager.click.rpc()
	if Input.is_action_just_released("lmb"):
		GameManager.unclick.rpc()


