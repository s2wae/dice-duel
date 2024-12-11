class_name MainMenu
extends Control


@onready var settings_menu = $settingsMenu


func ready():
	pass


func start_game():
	SceneManager.goto_scene("res://scenes/main_board_scenes/main.tscn")


func _on_start_button_pressed():
	start_game()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	settings_menu.visible = true
