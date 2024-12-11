class_name DiceMover
extends Node

@export var play_areas: Array[DicePlayArea]


func _ready() -> void:
	var die := get_tree().get_nodes_in_group("die")
	for dice: Dice in die:
		setup_dice(dice)


func setup_dice(dice: Dice) -> void:
	dice.drag_and_drop.drag_started.connect(_on_dice_drag_started.bind(dice))
	dice.drag_and_drop.drag_canceled.connect(_on_dice_drag_canceled.bind(dice))
	dice.drag_and_drop.dropped.connect(_on_dice_dropped.bind(dice))


func _set_highlighters(enabled: bool) -> void:
	for play_area: DicePlayArea in play_areas:
		play_area.tile_highlighter.enabled = enabled


func _get_play_area_for_position(global: Vector2) -> int:
	var dropped_area_index := -1
	
	for i in play_areas.size():
		var tile := play_areas[i].get_tile_from_global(global)
		if play_areas[i].is_tile_in_bounds(tile):
			dropped_area_index = i
	
	return dropped_area_index


func _reset_dice_to_starting_position(starting_position: Vector2, dice: Dice) -> void:
	var i := _get_play_area_for_position(starting_position)
	var tile := play_areas[i].get_tile_from_global(starting_position)
	
	dice.reset_after_dragging(starting_position)
	play_areas[i].dice_grid.add_dice(tile, dice)



func _move_dice(dice: Dice, play_area: DicePlayArea, tile: Vector2i) -> void:
	play_area.dice_grid.add_dice(tile, dice)
	dice.global_position = play_area.get_global_from_tile(tile) - Main.QUARTER_CELL_SIZE
	dice.reparent(play_area.dice_grid)


func _on_dice_drag_started(dice: Dice) -> void:
	_set_highlighters(true)
	
	var i := _get_play_area_for_position(dice.global_position)
	if i > -1:
		var tile := play_areas[i].get_tile_from_global(dice.global_position)
		play_areas[i].dice_grid.remove_dice(tile)


func _on_dice_drag_canceled(starting_position: Vector2, dice: Dice) -> void:
	_set_highlighters(false)
	_reset_dice_to_starting_position(starting_position, dice)


func _on_dice_dropped(starting_position: Vector2, dice: Dice) -> void:
	_set_highlighters(false)
	
	if dice.is_queued_for_deletion():
		return

	var old_area_index := _get_play_area_for_position(starting_position)
	var drop_area_index := _get_play_area_for_position(dice.get_global_mouse_position())
	
	if drop_area_index == -1:
		_reset_dice_to_starting_position(starting_position, dice)
		return

	var old_area := play_areas[old_area_index]
	var old_tile := old_area.get_tile_from_global(starting_position)
	var new_area := play_areas[drop_area_index]
	var new_tile := new_area.get_hovered_tile()
	
	if new_area.dice_grid.is_tile_occupied(new_tile):
		var old_dice: Dice = new_area.dice_grid.die[new_tile]
		new_area.dice_grid.remove_dice(new_tile)
		_move_dice(old_dice, old_area, old_tile)
	
	_move_dice(dice, new_area, new_tile)
