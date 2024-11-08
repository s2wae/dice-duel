extends Node2D

@onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	set_multiplayer_authority(str(name).to_int())
	if get_multiplayer_authority() == multiplayer.get_unique_id():
		print(get_multiplayer_authority())
		camera.enabled = true
		camera.make_current()


#this is still being assigned the wrong id so fix that,
#but the syncing can work i saw bug so try properly fix that
#find a way to not get ui of the other board to lock onto the current camera

func _process(delta):
	pass
