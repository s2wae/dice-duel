class_name DiceStats
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
@export var rarity: Rarity 
@export var gold_cost := 1
@export var traits: Array[Trait]
@export var pool_count := 15

@export_category("Visuals")
@export var skin_coordinates: Vector2i


func get_gold_value() -> int:
	return gold_cost


func get_trait_names() -> PackedStringArray:
	var trait_names: PackedStringArray = []
	for current_trait in traits:
		trait_names.append(current_trait.name)
	return trait_names


func _to_string() -> String:
	return name
