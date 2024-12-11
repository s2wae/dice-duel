class_name DicePool
extends Resource

@export var available_dices: Array[DiceStats]

var dice_pool: Array[DiceStats]


func generate_dice_pool() -> void:
	dice_pool = []
	
	for dice: DiceStats in available_dices:
		for i in dice.pool_count:
			dice_pool.append(dice)


func get_random_dice_by_rarity(rarity: DiceStats.Rarity) -> DiceStats:
	var dices := dice_pool.filter(
		func(dice: DiceStats):
			return dice.rarity == rarity
	)
	
	if dices.is_empty():
		return null
	
	var picked_dice: DiceStats = dices.pick_random()
	dice_pool.erase(picked_dice)
	
	return picked_dice


func add_dice(dice: DiceStats) -> void:
	dice = dice.duplicate()
	dice_pool.append(dice)
