@tool
class_name Unit
extends Area2D

signal quick_sell_pressed

@export var stats: UnitStats : set = set_stats
@export var game_state : GameState

@onready var fsm : FiniteStateMachine = $fsm
@onready var skin: Sprite2D = $skin
@onready var health_bar: ProgressBar = $hpBar
@onready var mana_bar: ProgressBar = $manaBar
@onready var tier_icon: TierSprite = $tierSprite
@onready var drag_and_drop: DragAndDrop = $dragAndDrop
@onready var animations: UnitAnimations = $unitAnimations
@onready var attack_range_collision : CollisionShape2D = %attackRangeCollision
@onready var detect_enemy_range : Area2D = %detectEnemyRange
@onready var is_alive : bool = true
@onready var benched : bool = true


var is_hovered : bool = false


func _ready() -> void:
	game_state.changed.connect(_on_game_state_changed)
	if not Engine.is_editor_hint():
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
	health_bar.max_value = stats.health_points
	health_bar.value = stats.health_points
	mana_bar.value = stats.mana_start
	attack_range_collision.shape.radius = stats.attack_range


func reset_after_dragging(starting_position: Vector2) -> void:
	global_position = starting_position


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


func _on_game_state_changed() -> void:
	if benched:
		detect_enemy_range.monitoring = false
		detect_enemy_range.monitorable = false
	else:
		detect_enemy_range.monitoring = true
		detect_enemy_range.monitorable = true
