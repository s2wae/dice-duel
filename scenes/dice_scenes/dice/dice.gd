@tool
class_name Dice
extends Area2D

signal quick_sell_pressed

@export var stats: DiceStats : set = set_stats

@onready var skin: Sprite2D = $skin
@onready var drag_and_drop: DragAndDrop = $dragAndDrop

var is_hovered := false


func _ready() -> void:
	if not Engine.is_editor_hint():
		drag_and_drop.drag_started.connect(_on_drag_started)
		drag_and_drop.drag_canceled.connect(_on_drag_canceled)


func _input(event: InputEvent) -> void:
	if not is_hovered:
		return
	
	if event.is_action_pressed("quick_sell"):
		quick_sell_pressed.emit()


func set_stats(value: DiceStats) -> void:
	stats = value
	
	if value == null:
		return
	
	if not Engine.is_editor_hint():
		stats = value.duplicate()
	
	if not is_node_ready():
		await ready
	
	skin.region_rect.position = Vector2(stats.skin_coordinates) * Main.HALF_CELL_SIZE


func reset_after_dragging(starting_position: Vector2) -> void:
	global_position = starting_position


func _on_drag_started() -> void:
	pass


func _on_drag_canceled(starting_position: Vector2) -> void:
	reset_after_dragging(starting_position)


func _on_mouse_entered() -> void:
	if drag_and_drop.dragging:
		return
	
	is_hovered = true
	z_index = 1


func _on_mouse_exited() -> void:
	if drag_and_drop.dragging:
		return
	
	is_hovered = false
	z_index = 0
