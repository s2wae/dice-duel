class_name Trait
extends Resource

@export var name: String
@export var icon: Texture
@export_multiline var description: String

@export_range(1, 3) var levels: int
@export var dice_requirements: Array[int]
@export var dice_modifiers: Array[PackedScene]


func get_unique_dice_count(die: Array[Dice]) -> int:
	die = die.filter(
		func(dice: Dice):
			return dice.stats.traits.has(self)
	)
	
	var unique_die: Array[String] = []
	
	for dice: Dice in die:
		if not unique_die.has(dice.stats.name):
			unique_die.append(dice.stats.name)
	
	return unique_die.size()


func get_levels_bbcode(dice_count: int) -> String:
	var code: PackedStringArray = []
	var reached_level := dice_requirements.filter(
		func(requirement: int):
			return dice_count >= requirement
	)
	
	for i: int in levels:
		if i == (reached_level.size()-1):
			code.append("[color=#fafa82]%s[/color]" % dice_requirements[i])
		else:
			code.append(str(dice_requirements[i]))
	
	return "/".join(code)


func is_active(unique_dice_count: int) -> bool:
	return unique_dice_count >= dice_requirements[0]


static func get_unique_traits_for_die(die: Array[Dice]) -> Array[Trait]:
	var traits: Array[Trait] = []
	
	for dice: Dice in die:
		for trait_data: Trait in dice.stats.traits:
			if not traits.has(trait_data):
				traits.append(trait_data)
	
	return traits
