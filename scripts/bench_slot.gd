extends ColorRect

var curState = Global.slotState.FREE
var benchSlotId = -1

func _ready():
	pass


# I think can apply this to the board slot as well btu do tomorow so tire :c

func _process(delta):
	curState = Global.slotState.FREE
	if $Area2D.has_overlapping_areas():
		curState = Global.slotState.USED


func _on_area_2d_area_entered(area):
	#if area.is_in_group("isUnit") and not Global.isDragging:
		#curState = Global.slotState.USED
	pass


func _on_area_2d_area_exited(area):
	#if area.is_in_group("isUnit"):
		#curState = Global.slotState.FREE
	pass

