class_name UnitSpawner
extends Node


signal unit_spawned(unit: Unit)

const UNIT = preload("res://scenes/unit_scenes/unit/unit.tscn")

@export var bench: UnitPlayArea
@export var board: UnitPlayArea


func _get_first_available_area() -> UnitPlayArea:
	if not bench.unit_grid.is_grid_full():
		return bench
	elif not board.unit_grid.is_grid_full():
		return board
	
	return null

# FIXME Spawn enemies not working. maybe just create new enemy scenes idk
func spawn_unit(unit: UnitStats) -> void:
	var area := _get_first_available_area()
	if area != null:
		var new_unit := UNIT.instantiate()
		var tile := area.unit_grid.get_first_empty_tile()
		area.unit_grid.add_child(new_unit)
		new_unit.stats = unit
		area.unit_grid.add_unit(tile, new_unit)
		new_unit.global_position = area.get_global_from_tile(tile) - Main.QUARTER_CELL_SIZE
		unit_spawned.emit(new_unit)
	else:
		print_debug("No available space to add dice to!")
