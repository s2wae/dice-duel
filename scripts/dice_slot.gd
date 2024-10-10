extends ColorRect

var curState = Global.slotState.FREE


func _ready():
	pass


func _process(delta):
	curState = Global.slotState.FREE
	if $diceArea.has_overlapping_areas():
		curState = Global.slotState.USED
