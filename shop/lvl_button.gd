class_name XPButton
extends Button

@export var player_stats: PlayerStats
@onready var hbox_container: HBoxContainer = $HBoxContainer


func _ready() -> void:
	player_stats.changed.connect(_on_player_stats_changed)
	_on_player_stats_changed()


func _on_player_stats_changed() -> void:
	var has_enough_gold := player_stats.gold >= 4
	var level_10 := player_stats.level == 10
	disabled = not has_enough_gold or level_10
	
	if has_enough_gold and not level_10:
		hbox_container.modulate.a = 1.0
	else:
		hbox_container.modulate.a = 0.5


func _on_pressed() -> void:
	player_stats.gold -= 4
	player_stats.xp += 4
