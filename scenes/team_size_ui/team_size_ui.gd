class_name TeamSizeUI
extends PanelContainer

@export var player_stats: PlayerStats
@export var board_grid: UnitGrid

@onready var unit_counter: Label = %unitCounter
@onready var warning_sprite: TextureRect = %warningSprite


func _ready() -> void:
	player_stats.changed.connect(_update)
	board_grid.unit_grid_changed.connect(_update)
	_update()


func _update() -> void:
	var units_used := board_grid.get_all_units().size()
	unit_counter.text = "%s/%s" % [units_used, player_stats.level]
	warning_sprite.visible = units_used > player_stats.level
