class_name Main
extends Node2D

signal board_check

const CELL_SIZE := Vector2(32, 32)
const HALF_CELL_SIZE := Vector2(16, 16)
const QUARTER_CELL_SIZE := Vector2(8, 8)
const CUSTOM_SKIN_SIZE := Vector2(18, 18)

@export var game_state : GameState
@export var player_board : UnitGrid
@export var enemy_board : EnemyGrid

@onready var sell_area: SellArea = $sellArea
@onready var unit_mover: UnitMover = $unitMover
@onready var unit_spawner: UnitSpawner = $unitSpawner
@onready var unit_combiner: UnitCombiner = $unitCombiner
@onready var dice_mover: DiceMover = $diceMover
@onready var dice_spawner: DiceSpawner = $diceSpawner
@onready var enemy_spawner: EnemySpawner = $enemySpawner
@onready var pause_menu : PauseMenu = %pauseMenu
@onready var shop: Shop = %shop
@onready var wave_counter : Label = %wave_counter
@onready var life_counter : Label = %life_counter

var enemy_board_array : Array = []
var player_board_array : Array = []
var player_board_pos : Array = []
var wave_count : int = 1
var life_count : int = 3

#TODO add more waves and score now
#TODO if possible add some dice modifier or sum idek

func _ready() -> void:
	board_check.connect(_on_board_check)
	game_state.changed.connect(_on_game_state_changed)
	
	unit_spawner.unit_spawned.connect(sell_area.setup_unit)
	unit_spawner.unit_spawned.connect(unit_mover.setup_unit)
	unit_spawner.unit_spawned.connect(unit_combiner.queue_unit_combination_update.unbind(1))
	
	dice_spawner.dice_spawned.connect(dice_mover.setup_dice)
	dice_spawner.dice_spawned.connect(sell_area.setup_dice)
	
	shop.unit_bought.connect(unit_spawner.spawn_unit)
	shop.dice_bought.connect(dice_spawner.spawn_dice)
	
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_menu.visible = true


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
		for i : Unit in player_board_array:
			i.global_position = player_board_pos[temp_count]
			temp_count += 1
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
