class_name DiceGrid
extends Node2D

signal dice_grid_changed

@export var size: Vector2i
@export var die: Dictionary


func _ready() -> void:
	for i in size.x:
		for j in size.y:
			die[Vector2i(i, j)] = null


func add_dice(tile: Vector2i, dice: Node) -> void:
	die[tile] = dice
	dice_grid_changed.emit()


func remove_dice(tile: Vector2i) -> void:
	var dice := die[tile] as Node
	
	if not dice:
		return
	
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
