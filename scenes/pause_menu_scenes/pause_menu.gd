class_name PauseMenu
extends Control


@export var settings_menu : Control


func _on_return_button_pressed() -> void:
	self.hide()


func _on_settings_button_pressed() -> void:
	settings_menu.visible = true


func _on_quit_button_pressed() -> void:
	get_tree().quit()
