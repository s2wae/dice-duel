extends Control

@export var coins = 15


var unit = preload("res://scenes/unit.tscn")
var briar = preload("res://placeholders/Briar.png")
var gwen = preload("res://placeholders/Gwen.png")
var milio = preload("res://placeholders/Milio.png")
var teemo = preload("res://placeholders/Teemo.png")
var varus = preload("res://placeholders/Varus.png")

var array = [briar, gwen, milio, teemo, varus] 

func _ready():
	$shopUI/coins.text = "Coins:" + str(coins)
	$shopUI/GridContainer/shopslot1.texture = array.pick_random()
	$shopUI/GridContainer/shopslot2.texture = array.pick_random()
	$shopUI/GridContainer/shopslot3.texture = array.pick_random()
	$shopUI/GridContainer/shopslot4.texture = array.pick_random()
	$shopUI/GridContainer/shopslot5.texture = array.pick_random()


func _process(delta):
	pass


func _on_reroll_button_pressed():
	
	if coins > 0:
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)
		$shopUI/GridContainer/shopslot1/Button1.visible = true
		$shopUI/GridContainer/shopslot2/Button2.visible = true
		$shopUI/GridContainer/shopslot3/Button3.visible = true
		$shopUI/GridContainer/shopslot4/Button4.visible = true
		$shopUI/GridContainer/shopslot5/Button5.visible = true
		
		$shopUI/GridContainer/shopslot1.modulate.a = 1
		$shopUI/GridContainer/shopslot2.modulate.a = 1
		$shopUI/GridContainer/shopslot3.modulate.a = 1
		$shopUI/GridContainer/shopslot4.modulate.a = 1
		$shopUI/GridContainer/shopslot5.modulate.a = 1
		
		$shopUI/GridContainer/shopslot1.texture = array.pick_random()
		$shopUI/GridContainer/shopslot2.texture = array.pick_random()
		$shopUI/GridContainer/shopslot3.texture = array.pick_random()
		$shopUI/GridContainer/shopslot4.texture = array.pick_random()
		$shopUI/GridContainer/shopslot5.texture = array.pick_random()


#This part needs to be changed a lot because jus testing to see if can make bench work
#I have no idea how to properly align it to the bench slot, and also need to make it draggable or sum
#to bring to board.
func _on_button_1_pressed():
	if coins > 0:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		print("unit successfully added")
		unit_instance.position = $boardUI/benchGrid/benchSlot.global_position
		unit_instance.position += Vector2(55,55)
		$shopUI/GridContainer/shopslot1.modulate.a = 0
		$shopUI/GridContainer/shopslot1/Button1.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)


func _on_button_2_pressed():
	if coins > 0:
		$shopUI/GridContainer/shopslot2.modulate.a = 0
		$shopUI/GridContainer/shopslot2/Button2.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)

func _on_button_3_pressed():
	if coins > 0:
		$shopUI/GridContainer/shopslot3.modulate.a = 0
		$shopUI/GridContainer/shopslot3/Button3.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)

func _on_button_4_pressed():
	if coins > 0:
		$shopUI/GridContainer/shopslot4.modulate.a = 0
		$shopUI/GridContainer/shopslot4/Button4.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)

func _on_button_5_pressed():
	if coins > 0:
		$shopUI/GridContainer/shopslot5.modulate.a = 0
		$shopUI/GridContainer/shopslot5/Button5.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)

#remove this thing ltr or work ard it, was jus testing, can change this later cos no gold back from sell
func _on_sell_pressed():
	get_tree().call_group("isUnit", "queue_free")
