class_name GameManager
extends Node

signal board_check


@export var player_board : UnitGrid
@export var enemy_board : EnemyGrid
@export var game_state : GameState
@export var enemy_spawner : EnemySpawner
@export var player_stats : PlayerStats

@onready var wave_count : int = 1
@onready var life_count : int = 3
@onready var wave_counter : Label = %wave_counter
@onready var life_counter : Label = %life_counter

var enemy_board_array : Array = []
var player_board_array : Array = []
var player_board_pos : Array = []
var john := preload("res://data/enemy_data/enemy_stats_data/enemy_resources/evil_john.tres")
var evil := preload("res://data/enemy_data/enemy_stats_data/enemy_resources/evil_bones.tres")
var evil_hand := preload("res://data/enemy_data/enemy_stats_data/enemy_resources/evil_hand.tres")




func spawn_wave() -> void:
	player_stats.gold += 20
	var tween := create_tween()
	match wave_count:
		1:
			for i in 1:
				tween.tween_callback(enemy_spawner.spawn_enemy.bind(john))
				tween.tween_interval(0.5)
		2: 
			for i in 3:
				tween.tween_callback(enemy_spawner.spawn_enemy.bind(john))
				tween.tween_interval(0.5)
		3: 
			for i in 2:
				tween.tween_callback(enemy_spawner.spawn_enemy.bind(john))
				tween.tween_callback(enemy_spawner.spawn_enemy.bind(evil))
				tween.tween_interval(0.5)
		4: 
			for i in 3:
				tween.tween_callback(enemy_spawner.spawn_enemy.bind(john))
				tween.tween_callback(enemy_spawner.spawn_enemy.bind(evil))
				tween.tween_interval(0.5)
		5: 
			for i in 1:
				tween.tween_callback(enemy_spawner.spawn_enemy.bind(evil_hand))
				tween.tween_interval(0.5)

func _ready() -> void:
	board_check.connect(_on_board_check)
	game_state.changed.connect(_on_game_state_changed)
	spawn_wave()


func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.FIGHT:
		player_board_array.clear()
		enemy_board_array.clear()
		player_board_array = player_board.get_all_units()
		enemy_board_array = enemy_board.get_all_enemies()
		for i in player_board_array:
			player_board_pos.append(i.global_position)
	else:
		wave_count += 1
		wave_counter.text = "Wave : " + str(wave_count)
		await get_tree().create_timer(0.5).timeout
		spawn_wave()


func _process(delta: float) -> void:
	if game_state.current_phase == GameState.Phase.FIGHT:
		for i: Unit in player_board_array:
			if i.is_alive == false:
				player_board_array.erase(i)
				board_check.emit()
		for i: Enemy in enemy_board_array:
			if i.is_alive == false:
				enemy_board_array.erase(i)
				board_check.emit()


func _on_board_check() -> void:
	var temp_count = 0
	if player_board_array.is_empty():
		await get_tree().create_timer(0.5).timeout
		game_state.current_phase = GameState.Phase.PLANNING
		player_board_array = player_board.get_all_units()
		life_count -= 1
		life_counter.text = "Life : " + str(life_count)
		if life_count <= 0:
			await get_tree().create_timer(1).timeout
			SceneManager.goto_scene("res://scenes/end_game_scenes/end_game.tscn")
		for i : Unit in player_board_array:
			i.global_position = player_board_pos[temp_count]			
			temp_count += 1
			await get_tree().create_timer(0.2).timeout
		for i : Enemy in enemy_board_array:
			i.queue_free()
	
	if enemy_board_array.is_empty():
		await get_tree().create_timer(0.5).timeout
		game_state.current_phase = GameState.Phase.PLANNING
		enemy_board_array = enemy_board.get_all_enemies()
		for i : Unit in player_board_array:
			i.global_position = player_board_pos[temp_count]
			temp_count += 1
		for i : Enemy in enemy_board_array:
			i.queue_free()
