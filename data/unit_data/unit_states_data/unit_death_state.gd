class_name UnitDeathState
extends State


@export var unit : Unit
@export var game_state : GameState


func _ready() -> void:
	game_state.changed.connect(_on_game_state_changed)

func enter():
	unit.is_alive = false
	unit.hide()



func exit():
	unit.is_alive = true
	unit.health_bar.value = unit.stats.health_points
	unit.mana_bar.value = unit.stats.mana_start
	unit.show()




func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.PLANNING:
		state_transition.emit(self, "idle")
