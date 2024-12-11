class_name UnitIdleState
extends State

@export var unit : Unit
@export var game_state : GameState

@onready var attack_range_collision : CollisionShape2D = %attackRangeCollision
@onready var detect_enemy_range_collision : CollisionShape2D = %detectEnemyRangeCollision
@onready var attack_range : Area2D = %attackRange
@onready var detect_enemy_range : Area2D = %detectEnemyRange

# TODO Make it so units on bench cannot be detected during fighting phase


func enter() -> void:
	game_state.changed.connect(_on_game_state_changed)
	attack_range.monitorable = false
	attack_range.monitoring = false
	detect_enemy_range.monitorable = false
	detect_enemy_range.monitoring = false


func exit() -> void:
	attack_range.monitorable = true
	attack_range.monitoring = true
	detect_enemy_range.monitorable = true
	detect_enemy_range.monitoring = true


func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.FIGHT:
		state_transition.emit(self, "search_enemy")
