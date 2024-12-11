class_name UnitStats
extends Resource

enum Rarity {COMMON, UNCOMMON, RARE, LEGENDARY}

const RARITY_COLORS := {
	Rarity.COMMON: Color("d1c8be"),
	Rarity.UNCOMMON: Color("319e52"),
	Rarity.RARE: Color("c338d9"),
	Rarity.LEGENDARY: Color("ea940b"),
}

@export var name: String

@export_category("Data")
@export var rarity : Rarity 
@export var gold_cost : int = 1
@export_range(1, 3) var tier : int = 1 : set = _set_tier
@export var health_points : int = 100
@export var mana_start : int = 20
@export var mana_gain : int = 10
@export var attack_dmg : int = 10
@export var attack_speed : float = .2
@export var attack_range : int = 60
@export var pool_count : int = 15
@export var move_speed : float = 0.2

@export_category("Visuals")
@export var skin_coordinates: Vector2i


func ability() -> void:
	pass


func get_combined_unit_count() -> int:
	return 3 ** (tier-1)


func get_gold_value() -> int:
	return gold_cost * get_combined_unit_count()


func get_trait_names() -> PackedStringArray:
	var trait_names: PackedStringArray = []
	return trait_names


func _set_tier(value: int) -> void:
	tier = value
	changed.emit()


func _to_string() -> String:
	return name
