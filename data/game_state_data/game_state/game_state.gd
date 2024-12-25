class_name GameState
extends Resource

enum Phase {PLANNING, FIGHT}

func _ready() -> void:
	var points : int = 0

@export var current_phase: Phase : 
	set(value):
		current_phase = value
		changed.emit()
