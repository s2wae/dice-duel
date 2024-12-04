class_name GameState
extends Resource

enum Phase {PREP, FIGHT}

@export var current_phase: Phase : 
	set(value):
		current_phase = value
		changed.emit()
