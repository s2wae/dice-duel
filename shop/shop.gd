class_name Shop
extends Control

signal unit_bought(unit: UnitStats)
signal dice_bought(dice: DiceStats)

const SHOP_UNIT_CARD = preload("res://shop/shop_slot.tscn")
const SHOP_DICE_CARD = preload("res://shop/dice_shop_slot.tscn")

@export var unit_pool: UnitPool
@export var dice_pool: DicePool
@export var player_stats: PlayerStats

@onready var shop_cards: HBoxContainer = %shopSlots
@onready var dice_shop_cards: VBoxContainer = %diceShopSlots

func _ready() -> void:
	unit_pool.generate_unit_pool()
	dice_pool.generate_dice_pool()
	
	for child: Node in shop_cards.get_children():
		child.queue_free()
	for child: Node in dice_shop_cards.get_children():
		child.queue_free()
	
	_roll_dice()
	_roll_units()


func _roll_units() -> void:
	for i in 5:
		var rarity := player_stats.get_random_rarity_for_level()
		var new_card := SHOP_UNIT_CARD.instantiate() as ShopSlot
		new_card.unit_stats = unit_pool.get_random_unit_by_rarity(rarity)
		new_card.unit_bought.connect(_on_unit_bought)
		shop_cards.add_child(new_card)


func _roll_dice() -> void:
	for i in 2:
		var rarity := player_stats.get_random_dice_rarity_for_level()
		var new_card := SHOP_DICE_CARD.instantiate() as DiceShopSlot
		new_card.dice_stats = dice_pool.get_random_dice_by_rarity(rarity)
		new_card.dice_bought.connect(_on_dice_bought)
		dice_shop_cards.add_child(new_card)


func _put_back_remaining_to_pool() -> void:
	for shop_card: ShopSlot in shop_cards.get_children():
		if not shop_card.bought:
			unit_pool.add_unit(shop_card.unit_stats)
		shop_card.queue_free()
	
	for dice_shop_card: DiceShopSlot in dice_shop_cards.get_children():
		if not dice_shop_card.bought:
			dice_pool.add_dice(dice_shop_card.dice_stats)
		dice_shop_card.queue_free()


func _on_unit_bought(unit: UnitStats) -> void:
	unit_bought.emit(unit)

func _on_dice_bought(dice: DiceStats) -> void:
	dice_bought.emit(dice)

func _on_reroll_button_pressed() -> void:
	_put_back_remaining_to_pool()
	_roll_units()
	_roll_dice()
