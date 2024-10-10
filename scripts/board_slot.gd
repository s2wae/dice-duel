extends ColorRect

@export var boardDisabled = false
var curState = Global.slotState.FREE
var boardSlotId = -1


func _ready():
	pass


func _process(delta):
	pass

func set_bgcolor(c):
	color = c


func _on_area_2d_area_entered(area):
	if area.is_in_group("isUnit"):
		pass


func _on_area_2d_area_exited(area):
	if area.is_in_group("isUnit"):
		pass
