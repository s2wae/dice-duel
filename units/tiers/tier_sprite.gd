class_name TierSprite
extends TextureRect

const TIER_ICONS := {
	1: preload("res://assets/units/tiers/level1.png"),
	2: preload("res://assets/units/tiers/level2.png"),
	3: preload("res://assets/units/tiers/level3.png"),
}

@export var stats: UnitStats : set = _set_stats


func _set_stats(value: UnitStats) -> void:
	if not is_node_ready():
		await ready

	stats = value
	stats.changed.connect(_on_stats_changed)


func _on_stats_changed() -> void:
	texture = TIER_ICONS[stats.tier]
