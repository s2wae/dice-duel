class_name EnemyAttackState
extends State

@export var current_target : Unit
@export var enemy : Enemy
@export var game_state : GameState
@export var attack_timer : Timer

@onready var unit_array : Array = []
@onready var attack_range : Area2D = %attackRange
@onready var can_attack : bool = false


#TODO make a update target function or something
# not sure if this should be in attack state or search, but probably search


func enter() -> void:
	game_state.changed.connect(_on_game_state_changed)
	attack_timer.wait_time = enemy.stats.attack_speed
	await get_tree().create_timer(0.1).timeout
	if game_state.current_phase == GameState.Phase.FIGHT:
		if !attack_range.has_overlapping_areas():
			can_attack = false
			state_transition.emit(self, "idle")
		for i in attack_range.get_overlapping_areas():
			if i.is_in_group("units") and i.is_alive:
				current_target = i
				can_attack = true
				break


func exit() -> void:
	can_attack = false
	attack_timer.stop()


func determine_attack() -> void:
	pass


func check_alive(current_target : Unit) -> void:
	if current_target.health_bar.value <= 0:
		state_transition.emit(self, "search_unit")


func attack() -> void:
	current_target.health_bar.value -= enemy.stats.attack_dmg
	check_alive(current_target)
	can_attack = false
	attack_timer.start()


func _process(delta: float) -> void:
	if enemy.health_bar.value <= 0:
		can_attack = false
		state_transition.emit(self, "death")
	if can_attack:
		attack()


func _on_attack_timer_timeout() -> void:
	can_attack = true


func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.PLANNING:
		state_transition.emit(self, "idle")
		can_attack = false
		attack_timer.stop()
