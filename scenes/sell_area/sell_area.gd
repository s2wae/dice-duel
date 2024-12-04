class_name SellArea
extends Area2D

@export var player_stats: PlayerStats

@onready var gold: HBoxContainer = %gold
@onready var gold_label: Label = %goldLabel

var current_unit: Unit
var current_dice: Dice

func _ready() -> void:
	var units := get_tree().get_nodes_in_group("units")
	var die := get_tree().get_nodes_in_group("die")
	for unit: Unit in units:
		setup_unit(unit)
	for dice: Dice in die:
		setup_dice(dice)


func setup_unit(unit: Unit) -> void:
	unit.drag_and_drop.dropped.connect(_on_unit_dropped.bind(unit))


func setup_dice(dice: Dice) -> void:
	dice.drag_and_drop.dropped.connect(_on_dice_dropped.bind(dice))


func _sell_unit(unit: Unit) -> void:
	player_stats.gold += unit.stats.get_gold_value()
	# TODO give items back to item pool
	# TODO put units back to the pool
	print(player_stats.gold)
	unit.queue_free()

func _sell_dice(dice: Dice) -> void:
	player_stats.gold += dice.stats.get_gold_value()
	# TODO give items back to item pool
	# TODO put units back to the pool
	print(player_stats.gold)
	dice.queue_free()


func _on_unit_dropped(_starting_position: Vector2, unit: Unit) -> void:
	if unit and unit == current_unit:
		_sell_unit(unit)


func _on_dice_dropped(_starting_position: Vector2, dice: Dice) -> void:
	if dice and dice == current_dice:
		_sell_dice(dice)


func _on_area_entered(object) -> void:
	if object.is_in_group("units"):
		current_unit = object
		gold_label.text = str(object.stats.get_gold_value())
		gold.show()
	else:
		current_dice = object
		gold_label.text = str(object.stats.get_gold_value())
		gold.show()


func _on_area_exited(object) -> void:
	if object.is_in_group("units"):
		if object and object == current_unit:
			current_unit = null
	else:
		if object and object == current_dice:
			current_dice = null
	gold.hide()
