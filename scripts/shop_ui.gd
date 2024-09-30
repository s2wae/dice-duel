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


func _on_reroll_button_pressed():
	$CanvasLayer/GridContainer/shopslot1/Button1.visible = true
	$CanvasLayer/GridContainer/shopslot2/Button2.visible = true
	$CanvasLayer/GridContainer/shopslot3/Button3.visible = true
	$CanvasLayer/GridContainer/shopslot4/Button4.visible = true
	$CanvasLayer/GridContainer/shopslot5/Button5.visible = true
	
	$CanvasLayer/GridContainer/shopslot1.modulate.a = 1
	$CanvasLayer/GridContainer/shopslot2.modulate.a = 1
	$CanvasLayer/GridContainer/shopslot3.modulate.a = 1
	$CanvasLayer/GridContainer/shopslot4.modulate.a = 1
	$CanvasLayer/GridContainer/shopslot5.modulate.a = 1
	
	$CanvasLayer/GridContainer/shopslot1.texture = array.pick_random()
	$CanvasLayer/GridContainer/shopslot2.texture = array.pick_random()
	$CanvasLayer/GridContainer/shopslot3.texture = array.pick_random()
	$CanvasLayer/GridContainer/shopslot4.texture = array.pick_random()
	$CanvasLayer/GridContainer/shopslot5.texture = array.pick_random()


func _on_button_1_pressed():
	$CanvasLayer/GridContainer/shopslot1.modulate.a = 0
	$CanvasLayer/GridContainer/shopslot1/Button1.visible = false

func _on_button_2_pressed():
	$CanvasLayer/GridContainer/shopslot2.modulate.a = 0
	$CanvasLayer/GridContainer/shopslot2/Button2.visible = false

func _on_button_3_pressed():
	$CanvasLayer/GridContainer/shopslot3.modulate.a = 0
	$CanvasLayer/GridContainer/shopslot3/Button3.visible = false

func _on_button_4_pressed():
	$CanvasLayer/GridContainer/shopslot4.modulate.a = 0
	$CanvasLayer/GridContainer/shopslot4/Button4.visible = false

func _on_button_5_pressed():
	$CanvasLayer/GridContainer/shopslot5.modulate.a = 0
	$CanvasLayer/GridContainer/shopslot5/Button5.visible = false
