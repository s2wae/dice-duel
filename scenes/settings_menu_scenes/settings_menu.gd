class_name SettingsMenu
extends Control

const RES_DICTIONARY : Dictionary = {
	"1152 x 648" : Vector2(1152, 648),
	"1280 x 720" : Vector2(1280, 720),
	"1980 x 1080" : Vector2(1980, 1080),
	"1980 x 1200" : Vector2(1980, 1200)
}

@onready var fullscreen_button = %fullscreenButton
@onready var res_button = %resolutionButton

func _ready() -> void:
	res_button.item_selected.connect(_on_resolution_selected)
	add_resolution_items()


func _on_resolution_selected(i : int) -> void:
	DisplayServer.window_set_size(RES_DICTIONARY.values()[i])


func add_resolution_items() -> void:
	for res_size_text in RES_DICTIONARY:
		res_button.add_item(res_size_text)


func _on_fullscreen_button_toggled(button_pressed : bool) -> void:
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen_button.get_theme_stylebox("normal").bg_color = "57b300"
		fullscreen_button.get_theme_stylebox("hover").bg_color = "57b300"
		fullscreen_button.get_theme_stylebox("pressed").bg_color = "57b300"
		fullscreen_button.get_theme_stylebox("presesd_hover").bg_color = "57b300"
		fullscreen_button.text = "ON"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen_button.get_theme_stylebox("normal").bg_color = "810002"
		fullscreen_button.get_theme_stylebox("hover").bg_color = "810002"
		fullscreen_button.get_theme_stylebox("pressed").bg_color = "810002"
		fullscreen_button.get_theme_stylebox("presesd_hover").bg_color = "810002"
		fullscreen_button.text = "OFF"


func _on_return_button_pressed() -> void:
	self.visible = false
