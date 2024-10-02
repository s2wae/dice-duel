extends ColorRect

var boardSlotId = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_bgcolor(c):
	color = c


func _on_area_2d_area_entered(area):
	if area.is_in_group("isUnit"):
		print("AREA OFF")
		Global.beingUsed = true


func _on_area_2d_area_exited(area):
	if area.is_in_group("isUnit"):
		print("AREA ON")
		Global.beingUsed = false
