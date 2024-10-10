extends Node2D


func _ready():
	get_tree().root.add_child(Global.curBoard)
	get_tree().root.add_child(Global.curBench)
	get_tree().root.add_child(Global.curDice)


func _process(delta):
	pass
