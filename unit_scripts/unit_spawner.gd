class_name UnitSpawner
extends Node

signal unit_spawned(unit: Unit)

const UNIT = preload("res://units/unit.tscn")

@export var bench: PlayArea
@export var board: PlayArea


func _get_first_available_area() -> PlayArea:
	if not bench.unit_grid.is_grid_full():
		return bench
	elif not board.unit_grid.is_grid_full():
		return board
	
	return null


func spawn_unit(unit: UnitStats) -> void:
	var area := _get_first_available_area()
	assert(area, "No available space to add unit to!")
	
	var new_unit := UNIT.instantiate()
	var tile := area.unit_grid.get_first_empty_tile()
	area.unit_grid.add_child(new_unit)
	area.unit_grid.add_unit(tile, new_unit)
	new_unit.global_position = area.get_global_from_tile(tile) - Main.QUARTER_CELL_SIZE
	new_unit.stats = unit
	unit_spawned.emit(new_unit)
