@tool
class_name Unit
extends Area2D

signal quick_sell_pressed

@export var stats: UnitStats : set = set_stats

@onready var skin: Sprite2D = $skin
@onready var health_bar: ProgressBar = $hpBar
@onready var mana_bar: ProgressBar = $manaBar
@onready var tier_icon: TierSprite = $tierSprite
@onready var drag_and_drop: DragAndDrop = $dragAndDrop
@onready var animations: UnitAnimations = $unitAnimations

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


func set_stats(value: UnitStats) -> void:
	stats = value
	
	if value == null:
		return
	
	if not Engine.is_editor_hint():
		stats = value.duplicate()
	
	if not is_node_ready():
		await ready
	
	skin.region_rect.position = Vector2(stats.skin_coordinates) * Main.CUSTOM_SKIN_SIZE 
	tier_icon.stats = stats


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
