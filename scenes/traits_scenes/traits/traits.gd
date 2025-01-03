class_name Traits
extends Control

const TRAIT_UI = preload("res://scenes/traits_scenes/trait_ui/trait_ui.tscn")

@export var game_state: GameState
@export var dice_grid: DiceGrid
@onready var trait_container: GridContainer = %traitContainer

var current_traits := {}
var traits_to_update: Array
var active_traits: Array[Trait]
var should_update := true


# FIXME: problem should be that the update trait call is not being done when dice is bought
# connect that signal and it should be fine?
# update: not fine

# FIXED: problem was that the dice was being assigned its spot first without changing
# the stats, and the base stat it was using was D1. so just made it so it updates the stats first
# and now it works. no idea if this will mess anything else up.

func _ready() -> void:
	game_state.changed.connect(_on_game_state_changed)
	dice_grid.dice_grid_changed.connect(_on_dice_grid_changed)
	
	for trait_ui: TraitUI in trait_container.get_children():
		trait_ui.queue_free()


func _update_traits() -> void:
	traits_to_update = current_traits.keys()
	active_traits = []
	var die := dice_grid.get_all_die()
	var traits := Trait.get_unique_traits_for_die(die)
	
	for trait_data: Trait in traits:
		if current_traits.has(trait_data):
			_update_trait_ui(trait_data, die)
		else:
			_create_trait_ui(trait_data, die)
	
	_move_active_traits_to_top()
	_delete_orphan_traits()


func _create_trait_ui(trait_data: Trait, die: Array[Dice]) -> void:
	var trait_ui := TRAIT_UI.instantiate() as TraitUI
	trait_container.add_child(trait_ui)
	trait_ui.trait_data = trait_data
	trait_ui.update(die)
	current_traits[trait_data] = trait_ui


func _update_trait_ui(trait_data: Trait, die: Array[Dice]) -> void:
	var trait_ui := current_traits[trait_data] as TraitUI
	trait_ui.update(die)
	traits_to_update.erase(trait_data)
	
	if trait_ui.active:
		active_traits.append(trait_data)


func _move_active_traits_to_top() -> void:
	for i in active_traits.size():
		var trait_ui := current_traits[active_traits[i]] as TraitUI
		trait_container.move_child(trait_ui, i)


func _delete_orphan_traits() -> void:
	for orphan_trait: Trait in traits_to_update:
		var trait_ui := current_traits[orphan_trait] as TraitUI
		current_traits.erase(orphan_trait)
		trait_ui.queue_free()


func _on_dice_grid_changed() -> void:
	if not should_update:
		return
	
	_update_traits()


func _on_game_state_changed() -> void:
	should_update = game_state.current_phase == GameState.Phase.PLANNING
