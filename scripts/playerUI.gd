extends Control


@export var gold = Global.goldCount
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

func _ready():
	$shopUI/GridContainer/shopslot1.texture = array.pick_random()
	$shopUI/GridContainer/shopslot2.texture = array.pick_random()
	$shopUI/GridContainer/shopslot3.texture = array.pick_random()
	$shopUI/GridContainer/shopslot4.texture = array.pick_random()
	$shopUI/GridContainer/shopslot5.texture = array.pick_random()


func _process(delta):
	gold = Global.goldCount
	$shopUI/gold.text = "Gold:" + str(gold)
	check_bench()


func check_bench():
	var tempSlot
	var tempCount = 4
	for i in range(0,4):
		tempSlot = bench_grid.get_child(i)
		if not tempSlot.get_node("Area2D").has_overlapping_areas():
			tempCount -= 1
	Global.benchCounter = tempCount

func _on_reroll_button_pressed():
	
	if gold > 0:
		Global.goldCount -= 1
		$shopUI/gold.text = "Gold:" + str(gold)
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
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot1.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/GridContainer/shopslot1.modulate.a = 0
		$shopUI/GridContainer/shopslot1/Button1.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1


func _on_button_2_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot2.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/GridContainer/shopslot2.modulate.a = 0
		$shopUI/GridContainer/shopslot2/Button2.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1


func _on_button_3_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot3.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/GridContainer/shopslot3.modulate.a = 0
		$shopUI/GridContainer/shopslot3/Button3.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1

func _on_button_4_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot4.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/GridContainer/shopslot4.modulate.a = 0
		$shopUI/GridContainer/shopslot4/Button4.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1

func _on_button_5_pressed():
	if gold > 0 and Global.benchCounter < 4:
		var unit_instance = unit.instantiate()
		add_child(unit_instance)
		unit_instance.get_node("Sprite2D").texture = $shopUI/GridContainer/shopslot5.texture
		for i in range(3,-1,-1):
			var curSlot = bench_grid.get_child(i)
			if curSlot.curState == Global.slotState.FREE:
				unit_instance.position = curSlot.global_position
				unit_instance.position += Vector2(55,55)
		$shopUI/GridContainer/shopslot5.modulate.a = 0
		$shopUI/GridContainer/shopslot5/Button5.visible = false
		Global.goldCount -= 1
		Global.benchCounter += 1

