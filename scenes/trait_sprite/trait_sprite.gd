class_name TraitSprite
extends TextureRect

@export var trait_data: Trait : set = _set_trait_data

@onready var icon: TextureRect = $sprite


func _set_trait_data(value: Trait) -> void:
	if not is_node_ready():
		await ready

	trait_data = value
	icon.texture = trait_data.icon
 
