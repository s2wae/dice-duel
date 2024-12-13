class_name EndGame
extends Control



func _on_play_again_pressed() -> void:
	SceneManager.goto_scene("res://scenes/main_board_scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
