extends Node2D


func _ready():
	for i in GameManager.players:
		get_tree().root.add_child(Global.curBoard)
		if multiplayer.get_unique_id() == 1:
			Global.curBoard.position += Vector2(240,0)


func _process(delta):
	pass
