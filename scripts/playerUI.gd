extends Control

@export var coins = 15
@onready var bench_grid = $boardUI/benchGrid
@onready var bench_slot1= $boardUI/benchGrid/benchSlot1
@onready var bench_slot2= $boardUI/benchGrid/benchSlot2
@onready var bench_slot3= $boardUI/benchGrid/benchSlot3
@onready var bench_slot4= $boardUI/benchGrid/benchSlot4

var unit = preload("res://scenes/unit.tscn")
var briar = preload("res://placeholders/Briar.png")
var gwen = preload("res://placeholders/Gwen.png")
var milio = preload("res://placeholders/Milio.png")
var teemo = preload("res://placeholders/Teemo.png")
var varus = preload("res://placeholders/Varus.png")

var boardSlot = preload("res://scenes/board_slot.tscn")
var benchSlot = preload("res://scenes/bench_slot.tscn")

var array = [briar, gwen, milio, teemo, varus] 

var boardArray = []
var benchArray = []

var benchCounter = -10

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


func _on_button_1_pressed():
	if coins > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot1.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		benchCounter += 1
		$shopUI/GridContainer/shopslot1.modulate.a = 0
		$shopUI/GridContainer/shopslot1/Button1.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)


func _on_button_2_pressed():
	if coins > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot2.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		benchCounter += 1
		$shopUI/GridContainer/shopslot2.modulate.a = 0
		$shopUI/GridContainer/shopslot2/Button2.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)

func _on_button_3_pressed():
	if coins > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot3.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		benchCounter += 1
		$shopUI/GridContainer/shopslot3.modulate.a = 0
		$shopUI/GridContainer/shopslot3/Button3.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)

func _on_button_4_pressed():
	if coins > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot4.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		benchCounter += 1
		$shopUI/GridContainer/shopslot4.modulate.a = 0
		$shopUI/GridContainer/shopslot4/Button4.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)

func _on_button_5_pressed():
	if coins > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot5.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		benchCounter += 1
		$shopUI/GridContainer/shopslot5.modulate.a = 0
		$shopUI/GridContainer/shopslot5/Button5.visible = false
		coins -= 1
		$shopUI/coins.text = "Coins:" + str(coins)

