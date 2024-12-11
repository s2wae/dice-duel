@tool
class_name Enemy
extends Area2D


@export var stats: UnitStats : set = set_stats

@onready var skin : Sprite2D = $skin
@onready var health_bar: ProgressBar = $hpBar
@onready var mana_bar : ProgressBar = $manaBar
@onready var tier_icon : TierSprite = $tierSprite
@onready var animations : UnitAnimations = $unitAnimations
@onready var attack_range_collision : CollisionShape2D = %attackRangeCollision
@onready var is_alive : bool = true

var is_hovered := false


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if not is_hovered:
		return


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
