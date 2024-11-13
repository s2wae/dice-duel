extends Resource

class_name UnitStats

enum UnitRarity {COMMON, UNCOMMON, RARE, VERY_RARE, LEGENDARY}

const RARITY_COLORS := {
	UnitRarity.COMMON : Color("f2dce7"),
	UnitRarity.UNCOMMON : Color("73ff8b"),
	UnitRarity.RARE : Color("4ee5ef"),
	UnitRarity.VERY_RARE : Color("ad4eef"),
	UnitRarity.LEGENDARY : Color("ffd700")
}

@export var name: String

@export_category("Data")
@export var rarity: UnitRarity 
@export var gold_cost := 1
@export_range(1, 5) var tier := 1 : set = _set_tier

@export_category("Visuals")
@export var skin_coordinates: Vector2i


func get_combined_unit_count() -> int:
	return 3 ** (tier-1)


func get_gold_value() -> int:
	return gold_cost * get_combined_unit_count()


func _set_tier(value: int) -> void:
	tier = value
	emit_changed()


func _to_string() -> String:
	return name
