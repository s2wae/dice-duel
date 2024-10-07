extends Control


@export var gold = Global.goldCount
@onready var dice_grid = $boardUI/diceGrid
@onready var bench_grid = $boardUI/benchGrid
@onready var bench_slot1= $boardUI/benchGrid/benchSlot1
@onready var bench_slot2= $boardUI/benchGrid/benchSlot2
@onready var bench_slot3= $boardUI/benchGrid/benchSlot3
@onready var bench_slot4= $boardUI/benchGrid/benchSlot4

var dice = preload("res://scenes/dice.tscn")
var unit = preload("res://scenes/unit.tscn")
var briar = preload("res://placeholders/Briar.png")
var gwen = preload("res://placeholders/Gwen.png")
var milio = preload("res://placeholders/Milio.png")
var teemo = preload("res://placeholders/Teemo.png")
var varus = preload("res://placeholders/Varus.png")

var boardSlot = preload("res://scenes/board_slot.tscn")
var benchSlot = preload("res://scenes/bench_slot.tscn")

var d1 = preload("res://placeholders/1_dot.png")
var d2 = preload("res://placeholders/2_dots.png")
var d3 = preload("res://placeholders/3_dots.png")
var d4 = preload("res://placeholders/4_dots.png")
var d5 = preload("res://placeholders/5_dots.png")
var d6 = preload("res://placeholders/6_dots.png")

var unitArray = [briar, gwen, milio, teemo, varus] 
var diceArray = [d1, d2, d3, d4, d5, d6]

var boardArray = []
var benchArray = []

func _ready():
	$shopUI/unitShop/shopslot1.texture = unitArray.pick_random()
	$shopUI/unitShop/shopslot2.texture = unitArray.pick_random()
	$shopUI/unitShop/shopslot3.texture = unitArray.pick_random()
	$shopUI/unitShop/shopslot4.texture = unitArray.pick_random()
	$shopUI/unitShop/shopslot5.texture = unitArray.pick_random()
	$shopUI/diceShop/diceshopslot1.texture = diceArray.pick_random()
	$shopUI/diceShop/diceshopslot2.texture = diceArray.pick_random()

func _process(delta):
	gold = Global.goldCount
	$shopUI/gold.text = "Gold:" + str(gold)
	check_bench()
	check_dice()


func check_bench():
	var tempSlot
	var tempCount = 4
	for i in range(0,4):
		tempSlot = bench_grid.get_child(i)
		if not tempSlot.get_node("Area2D").has_overlapping_areas():
			tempCount -= 1
	Global.benchCounter = tempCount


func check_dice():
	var tempSlot
	var tempCount = 2
	for i in range(0,2):
		tempSlot = dice_grid.get_child(i)
		if not tempSlot.get_node("Area2D").has_overlapping_areas():
			tempCount -= 1
	Global.dCounter = tempCount

func _on_reroll_button_pressed():
	
	if gold > 0:
		Global.goldCount -= 1
		$shopUI/gold.text = "Gold:" + str(gold)
		$shopUI/unitShop/shopslot1/Button1.visible = true
		$shopUI/unitShop/shopslot2/Button2.visible = true
		$shopUI/unitShop/shopslot3/Button3.visible = true
		$shopUI/unitShop/shopslot4/Button4.visible = true
		$shopUI/unitShop/shopslot5/Button5.visible = true
		$shopUI/diceShop/diceshopslot1/DButton1.visible = true
		$shopUI/diceShop/diceshopslot2/DButton2.visible = true
		
		$shopUI/unitShop/shopslot1.modulate.a = 1
		$shopUI/unitShop/shopslot2.modulate.a = 1
		$shopUI/unitShop/shopslot3.modulate.a = 1
		$shopUI/unitShop/shopslot4.modulate.a = 1
		$shopUI/unitShop/shopslot5.modulate.a = 1
		$shopUI/diceShop/diceshopslot1.modulate.a = 1
		$shopUI/diceShop/diceshopslot2.modulate.a = 1
		
		$shopUI/unitShop/shopslot1.texture = unitArray.pick_random()
		$shopUI/unitShop/shopslot2.texture = unitArray.pick_random()
		$shopUI/unitShop/shopslot3.texture = unitArray.pick_random()
		$shopUI/unitShop/shopslot4.texture = unitArray.pick_random()
		$shopUI/unitShop/shopslot5.texture = unitArray.pick_random()
		
		$shopUI/diceShop/diceshopslot1.texture = diceArray.pick_random()
		$shopUI/diceShop/diceshopslot2.texture = diceArray.pick_random()


func _on_button_1_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot1.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/unitShop/shopslot1.modulate.a = 0
		$shopUI/unitShop/shopslot1/Button1.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1


func _on_button_2_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot2.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/unitShop/shopslot2.modulate.a = 0
		$shopUI/unitShop/shopslot2/Button2.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1


func _on_button_3_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot3.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/unitShop/shopslot3.modulate.a = 0
		$shopUI/unitShop/shopslot3/Button3.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1

func _on_button_4_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot4.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/unitShop/shopslot4.modulate.a = 0
		$shopUI/unitShop/shopslot4/Button4.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1

func _on_button_5_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot5.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/unitShop/shopslot5.modulate.a = 0
		$shopUI/unitShop/shopslot5/Button5.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1

func _on_d_button_1_pressed():
	if gold > 0 and Global.dCounter < 2:
		var dice_instance = dice.instantiate()
		add_child(dice_instance)
		dice_instance.get_node("Sprite2D").texture = $shopUI/diceShop/diceshopslot1.texture
		for i in range(1,-1,-1):
			var curDSlot = dice_grid.get_child(i)
			if curDSlot.curState == Global.slotState.FREE:
				dice_instance.position = curDSlot.global_position
				dice_instance.position += Vector2(55,55)
		$shopUI/diceShop/diceshopslot1.modulate.a = 0
		$shopUI/diceShop/diceshopslot1/DButton1.visible = false
		Global.goldCount -= 1
		Global.dCounter += 1

func _on_d_button_2_pressed():
	if gold > 0 and Global.dCounter < 2:
		var dice_instance = dice.instantiate()
		add_child(dice_instance)
		dice_instance.get_node("Sprite2D").texture = $shopUI/diceShop/diceshopslot2.texture
		for i in range(1,-1,-1):
			var curSlot = dice_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				dice_instance.position = curSlot.global_position
				dice_instance.position += Vector2(55,55)
		$shopUI/diceShop/diceshopslot2.modulate.a = 0
		$shopUI/diceShop/diceshopslot2/DButton2.visible = false
		Global.goldCount -= 1
		Global.dCounter += 1



