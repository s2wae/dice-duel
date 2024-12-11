class_name DiceShopSlot
extends Button

signal dice_bought(dice: DiceStats)

const HOVER_BORDER_COLOR := Color("fafa82")

@export var player_stats: PlayerStats
@export var dice_stats: DiceStats : set = _set_dice_stats

@onready var traits: Label = %traits
@onready var bottom: Panel = %bottomSection
@onready var dice_name: Label = %diceName
@onready var gold_cost: Label = %goldCost
@onready var border: Panel = %border
@onready var empty_placeholder: Panel = %placeholder
@onready var dice_icon: TextureRect = %diceSprite
@onready var border_sb: StyleBoxFlat = border.get_theme_stylebox("panel")
@onready var bottom_sb: StyleBoxFlat = bottom.get_theme_stylebox("panel")

var bought := false
var border_color: Color


func _ready() -> void:
	player_stats.changed.connect(_on_player_stats_changed)
	_on_player_stats_changed()


func _set_dice_stats(value: DiceStats) -> void:
	dice_stats = value
	
	if not is_node_ready():
		await ready

	if not dice_stats:
		empty_placeholder.show()
		disabled = true
		bought = true
		return

	traits.text = "\n".join(dice_stats.get_trait_names())
	border_color = DiceStats.RARITY_COLORS[dice_stats.rarity]
	border_sb.border_color = border_color
	bottom_sb.bg_color = border_color.darkened(0.2)
	dice_name.text = dice_stats.name
	gold_cost.text = str(dice_stats.gold_cost)
	dice_icon.texture.region.position = Vector2(dice_stats.skin_coordinates) * Main.HALF_CELL_SIZE


func _on_mouse_entered() -> void:
	if not disabled:
		border_sb.border_color = HOVER_BORDER_COLOR


func _on_mouse_exited() -> void:
	border_sb.border_color = border_color


func _on_player_stats_changed() -> void:
	if not dice_stats:
		return
	
	var has_enough_gold := player_stats.gold >= dice_stats.gold_cost
	disabled = not has_enough_gold
	
	if has_enough_gold or bought:
		modulate = Color(Color.WHITE, 1.0)
	else:
		modulate = Color(Color.WHITE, 0.5)


func _on_pressed() -> void:
	if bought:
		return
	
	bought = true
	empty_placeholder.show()
	player_stats.gold -= dice_stats.gold_cost
	dice_bought.emit(dice_stats)
