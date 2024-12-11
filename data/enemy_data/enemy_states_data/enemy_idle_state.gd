class_name EnemyIdleState
extends State

@export var enemy : Enemy
@export var game_state : GameState

@onready var attack_range_collision : CollisionShape2D = %attackRangeCollision
@onready var detect_unit_range_collision : CollisionShape2D = %detectUnitRangeCollision
@onready var attack_range : Area2D = %attackRange
@onready var detect_unit_range : Area2D = %detectUnitRange


func enter() -> void:
	game_state.changed.connect(_on_game_state_changed)
	attack_range.monitorable = false
	attack_range.monitoring = false
	detect_unit_range.monitorable = false
	detect_unit_range.monitoring = false


func exit() -> void:
	attack_range.monitorable = true
	attack_range.monitoring = true
	detect_unit_range.monitorable = true
	detect_unit_range.monitoring = true


func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.FIGHT:
		state_transition.emit(self, "search_unit")
