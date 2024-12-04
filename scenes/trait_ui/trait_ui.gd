class_name TraitUI
extends PanelContainer

@export var trait_data: Trait : set = _set_trait_data
@export var active: bool : set = _set_active

@onready var trait_sprite: TraitSprite = %traitSprite
@onready var active_die: Label = %activeDie
@onready var trait_level: RichTextLabel = %traitLevel
@onready var trait_name: Label = %traitName


func update(die: Array[Dice]) -> void:
	var unique_die := trait_data.get_unique_dice_count(die)
	active_die.text = str(unique_die)
	trait_level.text = trait_data.get_levels_bbcode(unique_die)
	active = trait_data.is_active(unique_die)


func _set_trait_data(value: Trait) -> void:
	if not is_node_ready():
		await ready

	trait_data = value
	trait_sprite.trait_data = trait_data
	trait_name.text = trait_data.name


func _set_active(value: bool) -> void:
	active = value

	if active:
		modulate.a = 1.0
	else:
		modulate.a = 0.5
