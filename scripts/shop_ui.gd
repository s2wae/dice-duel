extends Control

var briar = preload("res://placeholders/Briar.png")
var gwen = preload("res://placeholders/Gwen.png")
var milio = preload("res://placeholders/Milio.png")
var teemo = preload("res://placeholders/Teemo.png")
var varus = preload("res://placeholders/Varus.png")

var array = [briar, gwen, milio, teemo, varus] 

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$CanvasLayer/GridContainer/TextureRect.modulate.a = 0
	$CanvasLayer/GridContainer/TextureRect/Button.visible = false
	print("hello")
	


func _on_reroll_button_pressed():
	%Button.visible = true
	
	$CanvasLayer/GridContainer/TextureRect.modulate.a = 1
	$CanvasLayer/GridContainer/TextureRect2.modulate.a = 1
	$CanvasLayer/GridContainer/TextureRect3.modulate.a = 1
	$CanvasLayer/GridContainer/TextureRect4.modulate.a = 1
	$CanvasLayer/GridContainer/TextureRect5.modulate.a = 1
	
	$CanvasLayer/GridContainer/TextureRect.texture = array.pick_random()
	$CanvasLayer/GridContainer/TextureRect2.texture = array.pick_random()
	$CanvasLayer/GridContainer/TextureRect3.texture = array.pick_random()
	$CanvasLayer/GridContainer/TextureRect4.texture = array.pick_random()
	$CanvasLayer/GridContainer/TextureRect5.texture = array.pick_random()
