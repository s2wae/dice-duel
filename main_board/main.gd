class_name Main
extends Node2D

const CELL_SIZE := Vector2(32, 32)
const HALF_CELL_SIZE := Vector2(16, 16)
const QUARTER_CELL_SIZE := Vector2(8, 8)

@onready var unit_mover: UnitMover = $unitMover
@onready var unit_spawner: UnitSpawner = $unitSpawner


func _ready() -> void:
	unit_spawner.unit_spawned.connect(unit_mover.setup_unit)
