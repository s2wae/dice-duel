class_name FightButton
extends Button


@export var player_stats: PlayerStats 
@export var game_state: GameState
@export var board: UnitGrid

@onready var hbox_container: HBoxContainer = $HBoxContainer


func _ready() -> void:
	board.unit_grid_changed.connect(_on_unit_grid_changed)
	_on_unit_grid_changed()


func _on_unit_grid_changed():
	var can_fight : bool =  player_stats.level >= board.get_all_units().size()
	disabled = not can_fight
	
	if can_fight and game_state.current_phase == GameState.Phase.PLANNING:
		hbox_container.modulate.a = 1
	else:
		hbox_container.modulate.a = 0.5


func _on_pressed() -> void:
	game_state.current_phase = GameState.Phase.FIGHT
	_on_unit_grid_changed()
	disabled = true
