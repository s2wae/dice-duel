class_name UnitAttackState
extends State


@export var unit : Unit
@export var current_target : Enemy
@export var attack_timer : Timer
@export var game_state : GameState

@onready var enemy_array : Array = []
@onready var attack_range : Area2D = %attackRange
@onready var can_attack : bool = false


func enter() -> void:
	game_state.changed.connect(_on_game_state_changed)
	attack_timer.wait_time = unit.stats.attack_speed
	await get_tree().create_timer(0.1).timeout
	if game_state.current_phase == GameState.Phase.FIGHT:
		if !attack_range.has_overlapping_areas():
			can_attack = false
			state_transition.emit(self, "idle")
		for i in attack_range.get_overlapping_areas():
			if i.is_in_group("enemy") and i.is_alive:
				current_target = i
				can_attack = true
				break


func exit() -> void:
	can_attack = false
	attack_timer.stop()


func determine_attack() -> void:
	pass


func check_alive(current_target : Enemy) -> void:
	if current_target.health_bar.value <= 0:
		state_transition.emit(self, "search_enemy")


func attack() -> void:
	current_target.health_bar.value -= unit.stats.attack_dmg
	check_alive(current_target)
	can_attack = false
	attack_timer.start()


func _process(delta: float) -> void:
	if unit.health_bar.value <= 0:
		can_attack = false
		state_transition.emit(self, "death")
	if can_attack:
		attack()


func _on_attack_timer_timeout() -> void:
	can_attack = true


func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.PLANNING:
		can_attack = false
		attack_timer.stop()
		state_transition.emit(self, "idle")
