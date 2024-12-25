class_name Main
extends Node2D



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

func _ready() -> void:
	
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
