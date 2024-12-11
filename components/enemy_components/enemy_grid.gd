class_name EnemyGrid
extends Node2D


signal enemy_grid_changed


@export var size: Vector2i
var enemies: Dictionary

func _ready() -> void:
	for i in size.x:
		for j in size.y:
			enemies[Vector2i(i, j)] = null


func add_enemy(tile: Vector2i, enemy: Node) -> void:
	enemies[tile] = enemy
	enemy.tree_exited.connect(_on_enemy_tree_exited.bind(enemy, tile))
	enemy_grid_changed.emit()


func remove_enemy(tile: Vector2i) -> void:
	var enemy := enemies[tile] as Node
	
	if not enemy:
		return
	
	enemy.tree_exited.disconnect(_on_enemy_tree_exited)
	enemies[tile] = null
	enemy_grid_changed.emit()


func is_tile_occupied(tile: Vector2i) -> bool:
	return enemies[tile] != null


func is_grid_full() -> bool:
	return enemies.keys().all(is_tile_occupied)


func get_first_empty_tile() -> Vector2i:
	for tile in enemies:
		if not is_tile_occupied(tile):
			return tile
	return Vector2i(-1, -1)


func get_all_enemies() -> Array[Enemy]:
	var enemy_array: Array[Enemy] = []
	
	for enemy: Enemy in enemies.values():
		if enemy:
			enemy_array.append(enemy)
	
	return enemy_array


func _on_enemy_tree_exited(enemy: Enemy, tile: Vector2i) -> void:
	if enemy.is_queued_for_deletion():
		enemies[tile] = null
		enemy_grid_changed.emit()
