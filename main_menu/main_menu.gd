class_name MainMenu
extends Control


func ready():
	pass


func start_game():
	SceneManager.goto_scene("res://main_board/main.tscn")


func _on_start_button_pressed():
	start_game()
