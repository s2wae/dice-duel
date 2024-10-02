extends Node2D


func _ready():
	pass


func _process(delta):
	pass

#testing purposes
func _on_area_2d_mouse_entered():
	print("HELLO!")


func _on_area_2d_mouse_exited():
	queue_free()
