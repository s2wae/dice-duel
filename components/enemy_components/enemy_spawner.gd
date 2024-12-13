class_name EnemySpawner
extends Node


signal enemy_spawned(enemy: Unit)

const ENEMY = preload("res://scenes/enemy_scenes/enemy.tscn")

@export var enemy_board: EnemyPlayArea



func _get_first_available_area() -> EnemyPlayArea:
	if not enemy_board.enemy_grid.is_grid_full():
		return enemy_board
	
	return null


func spawn_enemy(enemy: UnitStats) -> void:
	var area := _get_first_available_area()
	if area != null:
		var new_enemy := ENEMY.instantiate()
		var tile := area.enemy_grid.get_first_empty_tile()
		area.enemy_grid.add_child(new_enemy)
		new_enemy.stats = enemy
		area.enemy_grid.add_enemy(tile, new_enemy)
		new_enemy.global_position = area.get_global_from_tile(tile) - Main.QUARTER_CELL_SIZE
		enemy_spawned.emit(new_enemy)
	else:
		print_debug("No available space to add dice to!")
