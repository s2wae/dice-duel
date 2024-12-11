class_name EnemyDeathState
extends State

@export var enemy : Enemy
@export var game_state : GameState


func _ready() -> void:
	game_state.changed.connect(_on_game_state_changed)

func enter():
	enemy.is_alive = false
	enemy.hide()
	enemy.PROCESS_MODE_DISABLED


func exit():
	enemy.is_alive = true
	enemy.health_bar.value = enemy.stats.health_points
	enemy.mana_bar.value = enemy.stats.mana_start
	enemy.show()
	enemy.PROCESS_MODE_ALWAYS



func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.PLANNING:
		state_transition.emit(self, "idle")
