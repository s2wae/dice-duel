class_name DiceSpawner
extends Node

signal dice_spawned(dice: Dice)

const DICE = preload("res://dice/dice.tscn")

@export var bench: DicePlayArea


func _get_first_available_area() -> DicePlayArea:
	if not bench.dice_grid.is_grid_full():
		return bench
	
	return null


func spawn_dice(dice: DiceStats) -> void:
	var area := _get_first_available_area()
	if area:
		var new_dice := DICE.instantiate()
		var tile := area.dice_grid.get_first_empty_tile()
		area.dice_grid.add_child(new_dice)
		area.dice_grid.add_dice(tile, new_dice)
		new_dice.global_position = area.get_global_from_tile(tile) - Main.QUARTER_CELL_SIZE
		new_dice.stats = dice
		dice_spawned.emit(new_dice)
	else:
		print_debug("No available space to add dice to!")
