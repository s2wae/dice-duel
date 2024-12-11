class_name UnitEnemySearchState
extends State

@export var unit : Unit
@export var game_state : GameState

@onready var attack_range : Area2D = %attackRange
@onready var detect_enemy_range : Area2D = %detectEnemyRange
@onready var can_chase : bool = false
@onready var current_target : Enemy
@onready var attack_range_collision : CollisionShape2D = %attackRangeCollision
@onready var detect_enemy_range_collision : CollisionShape2D = %detectEnemyRangeCollision



func enter() -> void:
	await get_tree().create_timer(0.1).timeout
	if !detect_enemy_range.has_overlapping_areas():
		can_chase = false
		state_transition.emit(self, "idle")
	for i in detect_enemy_range.get_overlapping_areas():
		if i.is_in_group("enemy") and i.is_alive:
			current_target = i
			can_chase = true
			break
	for i in attack_range.get_overlapping_areas():
		if i.is_in_group("enemy") and i.is_alive:
			state_transition.emit(self, "attack")
			break


func exit() -> void:
	can_chase = false


func _on_attack_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		state_transition.emit(self, "attack")


func _process(delta: float) -> void:
	if unit.health_bar.value <= 0:
		state_transition.emit(self, "death")
	if can_chase:
		var direction = current_target.global_position - unit.global_position
		unit.position += direction.normalized() * unit.stats.move_speed
		if direction.x < 0: 
			unit.skin.flip_h = true
		else:
			unit.skin.flip_h = false
