extends MultiplayerSynchronizer

@export var clicking = false
@export var mousePos : Vector2

func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


func _process(delta):
	if Input.is_action_just_pressed("lmb"):
		mousePos = get_viewport().get_mouse_position()
		click.rpc()
	if Input.is_action_just_released("lmb"):
		unclick.rpc()


@rpc("any_peer", "call_local")
func click():
	clicking = true
	print(mousePos)


@rpc("any_peer", "call_local")
func unclick():
	clicking = false
	print(mousePos)
