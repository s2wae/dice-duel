class_name UnitGrid
extends Node2D



signal unit_grid_changed


@export var size: Vector2i
@export var game_state : GameState
@export var unit_grid : UnitGrid

var units: Dictionary
var units_pos : Dictionary
var enemy: Dictionary



func _ready() -> void:
	game_state.changed.connect(_on_game_state_changed)
	for i in size.x:
		for j in size.y:
			units[Vector2i(i, j)] = null
			units_pos[Vector2i(i, j)] = null


func add_unit(tile: Vector2i, unit: Node) -> void:
	units[tile] = unit
	if unit_grid.name == "benchUnitgrid":
		unit.benched = true
	else:
		unit.benched = false
	await get_tree().create_timer(0.1).timeout
	units_pos[tile] = unit.position
	unit.tree_exited.connect(_on_unit_tree_exited.bind(unit, tile))
	unit_grid_changed.emit()


func remove_unit(tile: Vector2i) -> void:
	var unit := units[tile] as Node
	
	if not unit:
		return
	
	unit.tree_exited.disconnect(_on_unit_tree_exited)
	units[tile] = null
	units_pos[tile] = null
	unit_grid_changed.emit()


func is_tile_occupied(tile: Vector2i) -> bool:
	return units[tile] != null


func is_grid_full() -> bool:
	return units.keys().all(is_tile_occupied)


func get_first_empty_tile() -> Vector2i:
	for tile in units:
		if not is_tile_occupied(tile):
			return tile
	return Vector2i(-1, -1)


func get_all_units() -> Array[Unit]:
	var unit_array: Array[Unit] = []
	
	for unit: Unit in units.values():
		if unit:
			unit_array.append(unit)
	
	return unit_array


func _on_unit_tree_exited(unit: Unit, tile: Vector2i) -> void:
	if unit.is_queued_for_deletion():
		units[tile] = null
		unit_grid_changed.emit()


func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.PLANNING:
		for tile in units:
			var unit := units[tile] as Node
			if is_tile_occupied(tile):
				unit.position = units_pos[tile]
