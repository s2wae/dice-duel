class_name EnemySearchUnitState
extends State

@export var enemy : Enemy
@export var game_state : GameState

@onready var attack_range : Area2D = %attackRange
@onready var detect_unit_range : Area2D = %detectUnitRange
@onready var can_chase : bool = false
@onready var current_target : Unit
@onready var attack_range_collision : CollisionShape2D = %attackRangeCollision
@onready var detect_unit_range_collision : CollisionShape2D = %detectUnitRangeCollision



func enter() -> void:
	game_state.changed.connect(_on_game_state_changed)
	await get_tree().create_timer(0.1).timeout
	if !detect_unit_range.has_overlapping_areas():
		can_chase = false
		state_transition.emit(self, "idle")
	for i in detect_unit_range.get_overlapping_areas():
		if i.is_in_group("units") and i.is_alive:
			current_target = i
			can_chase = true
			break
	for i in attack_range.get_overlapping_areas():
		if i.is_in_group("units") and i.is_alive:
			state_transition.emit(self, "attack")
			break


func exit() -> void:
	can_chase = false


func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("units"):
		state_transition.emit(self, "attack")


func _process(delta: float) -> void:
	if enemy.health_bar.value <= 0:
		state_transition.emit(self, "death")
	if can_chase:
		var direction = current_target.global_position - enemy.global_position
		enemy.position += direction.normalized() * enemy.stats.move_speed
		if direction.x < 0: 
			enemy.skin.flip_h = true
		else:
			enemy.skin.flip_h = false


func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.PLANNING:
		state_transition.emit(self, "idle")
