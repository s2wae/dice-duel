class_name DiceGrid
extends Node2D

signal dice_grid_changed


@export var size: Vector2i
@export var game_state : GameState

var die: Dictionary


func _ready() -> void:
	game_state.changed.connect(_on_game_state_changed)
	for i in size.x:
		for j in size.y:
			die[Vector2i(i, j)] = null


func add_dice(tile: Vector2i, dice: Node) -> void:
	die[tile] = dice
	dice.tree_exited.connect(_on_dice_tree_exited.bind(dice, tile))
	dice_grid_changed.emit()


func remove_dice(tile: Vector2i) -> void:
	var dice := die[tile] as Node
	
	if not dice:
		return
	
	dice.tree_exited.disconnect(_on_dice_tree_exited)
	die[tile] = null
	dice_grid_changed.emit()


func is_tile_occupied(tile: Vector2i) -> bool:
	return die[tile] != null


func is_grid_full() -> bool:
	return die.keys().all(is_tile_occupied)


func get_first_empty_tile() -> Vector2i:
	for tile in die:
		if not is_tile_occupied(tile):
			return tile
	return Vector2i(-1, -1)


func get_all_die() -> Array[Dice]:
	var dice_array: Array[Dice] = []
	
	for dice: Dice in die.values():
		if dice:
			dice_array.append(dice)
	
	return dice_array


func _on_dice_tree_exited(dice: Dice, tile: Vector2i) -> void:
	if dice.is_queued_for_deletion():
		die[tile] = null
		dice_grid_changed.emit()


func _on_game_state_changed() -> void:
	if game_state.current_phase == GameState.Phase.PLANNING:
		for tile in die:
			if is_tile_occupied(tile):
				remove_dice(tile)
