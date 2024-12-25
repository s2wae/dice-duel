class_name EndGame
extends Control

@onready var score_label : Label = %scoreLabel

func _ready() -> void:
	score_label.text = "Score:" + str(Global.score)


func _on_play_again_pressed() -> void:
	SceneManager.goto_scene("res://scenes/main_board_scenes/main.tscn")


func _on_quit_pressed() -> void:
	Global.score = 0
	get_tree().quit()
