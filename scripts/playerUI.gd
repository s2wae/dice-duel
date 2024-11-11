extends Node2D


@onready var dice_grid = $benchUI/diceGrid
@onready var bench_grid = $benchUI/benchGrid
@export var gold = 30


var readyStatus = 0
var battleStage = preload("res://scenes/battle_stage.tscn")
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
var benchCounter = 0
var dCounter = 0
var boardArray = []
var benchArray = []
var tempBench
var tempDice


@rpc("any_peer", "call_local")
func update_bench_path():
	print("CUR BENCH PATH" + str(bench_grid.get_path()))

#find a way to sync unit spawn and stuff


func _ready():
	$shopUI/unitShop/shopslot1.texture = unitArray.pick_random()
	$shopUI/unitShop/shopslot2.texture = unitArray.pick_random()
	$shopUI/unitShop/shopslot3.texture = unitArray.pick_random()
	$shopUI/unitShop/shopslot4.texture = unitArray.pick_random()
	$shopUI/unitShop/shopslot5.texture = unitArray.pick_random()
	$shopUI/diceShop/diceshopslot1.texture = diceArray.pick_random()
	$shopUI/diceShop/diceshopslot2.texture = diceArray.pick_random()
	


func _process(delta):
	$shopUI/gold.text = "Gold:" + str(gold)


#plz find it out, it may be this check bench func or smthg

func check_bench():
	var tempSlot
	var tempCount = 4
	for i in range(0,4):
		tempSlot = bench_grid.get_child(i)
		if not tempSlot.get_node("benchArea").has_overlapping_areas():
			tempCount -= 1
	benchCounter = tempCount


func check_dice():
	var tempSlot
	var tempCount = 2
	for i in range(0,2):
		tempSlot = dice_grid.get_child(i)
		if not tempSlot.get_node("diceArea").has_overlapping_areas():
			tempCount -= 1
	dCounter = tempCount


func _on_reroll_button_pressed():
	if gold > 0:
		gold -= 1
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
	check_bench()
	if gold > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot1.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.get_child_count() != 2:
				unit_instance.reparent(curSlot)
				unit_instance.position = get_parent().position
				unit_instance.position += Vector2(55,55)
				break
		$shopUI/unitShop/shopslot1.modulate.a = 0
		$shopUI/unitShop/shopslot1/Button1.visible = false
		gold -= 1
		benchCounter += 1
		
#print something here to test


func _on_button_2_pressed():
	check_bench()
	if gold > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot2.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.get_child_count() != 2:
				unit_instance.reparent(curSlot)
				unit_instance.position = get_parent().position
				unit_instance.position += Vector2(55,55)
				break
		$shopUI/unitShop/shopslot2.modulate.a = 0
		$shopUI/unitShop/shopslot2/Button2.visible = false
		gold -= 1
		benchCounter += 1


func _on_button_3_pressed():
	check_bench()
	if gold > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot3.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.get_child_count() != 2:
				unit_instance.reparent(curSlot)
				unit_instance.position = get_parent().position
				unit_instance.position += Vector2(55,55)
				break
		$shopUI/unitShop/shopslot3.modulate.a = 0
		$shopUI/unitShop/shopslot3/Button3.visible = false
		gold -= 1
		benchCounter += 1

func _on_button_4_pressed():
	check_bench()
	if gold > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot4.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.get_child_count() != 2:
				unit_instance.reparent(curSlot)
				unit_instance.position = get_parent().position
				unit_instance.position += Vector2(55,55)
				break
		$shopUI/unitShop/shopslot4.modulate.a = 0
		$shopUI/unitShop/shopslot4/Button4.visible = false
		gold -= 1
		benchCounter += 1

func _on_button_5_pressed():
	check_bench()
	if gold > 0 and benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/unitShop/shopslot5.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.get_child_count() != 2:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
				unit_instance.reparent(curSlot)
				print(unit_instance.global_position)
				break
		$shopUI/unitShop/shopslot5.modulate.a = 0
		$shopUI/unitShop/shopslot5/Button5.visible = false
		gold -= 1
		benchCounter += 1

func _on_d_button_1_pressed():
	check_dice()
	if gold > 0 and dCounter < 2:
		var dice_instance = dice.instantiate()
		add_child(dice_instance)
		dice_instance.get_node("Sprite2D").texture = $shopUI/diceShop/diceshopslot1.texture
		for i in range(1,-1,-1):
			var curDSlot = dice_grid.get_child(i)
			if curDSlot.get_child_count() != 2:
				dice_instance.reparent(curDSlot)
				dice_instance.position = get_parent().position
				dice_instance.position += Vector2(55,55)
				break
		$shopUI/diceShop/diceshopslot1.modulate.a = 0
		$shopUI/diceShop/diceshopslot1/DButton1.visible = false
		gold -= 1
		dCounter += 1
	print(dice_grid.get_path())

func _on_d_button_2_pressed():
	check_dice()
	if gold > 0 and dCounter < 2:
		var dice_instance = dice.instantiate()
		add_child(dice_instance)
		dice_instance.get_node("Sprite2D").texture = $shopUI/diceShop/diceshopslot2.texture
		for i in range(1,-1,-1):
			var curDSlot = dice_grid.get_child(i)
			if curDSlot.get_child_count() != 2:
				dice_instance.reparent(curDSlot)
				dice_instance.position = get_parent().position
				dice_instance.position += Vector2(55,55)
				break
		$shopUI/diceShop/diceshopslot2.modulate.a = 0
		$shopUI/diceShop/diceshopslot2/DButton2.visible = false
		gold -= 1
		dCounter += 1



#WORK IWTH MUTLIPLAYER SYNCHRONIZER NOW SEE HOW IT WORKS

#i think the problem is that there is not hostBoard on client side and vice versa
#so try to make it so client sends board info to server instead
#rn just client not getting updated, if fix that i think can move on
#try adding the board to player info instead
