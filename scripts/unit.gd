extends Node2D

@onready var boardSlot = preload("res://scenes/board_slot.tscn")

var canDrag = false
var isInDropArea = false
var curBoardSlot
var initialPos
var bodyRef


func _ready():
	pass


func _process(delta):
	
	if canDrag:
		if Input.is_action_just_pressed("lmb"):
			initialPos = global_position
			Global.isDragging = true
		if Input.is_action_pressed("lmb"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("lmb"):
			Global.isDragging = false
			var tween = get_tree().create_tween()
			if isInDropArea and curBoardSlot.curState == Global.slotState.FREE:
				tween.tween_property(self, "position", bodyRef.global_position + Vector2(75,75), .2).set_ease(Tween.EASE_OUT)
				if Input.is_action_just_released('lmb'):
					print("DISABLED")
					curBoardSlot.curState = Global.slotState.USED
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

 #and curBoardSlot.curState == Global.slotState.FREE

func _on_area_2d_area_entered(area):
	if area.is_in_group('droppable'):
		curBoardSlot = area.get_node("..")
		print(curBoardSlot.curState)
		isInDropArea = true
		bodyRef = area


func _on_area_2d_area_exited(area):
	if(!area.has_overlapping_areas()):
		if area.is_in_group('droppable'):
			curBoardSlot.curState = Global.slotState.FREE
			print(curBoardSlot.curState)
			print("OUT DROP AREA")
			isInDropArea = false


func _on_area_2d_mouse_entered():
	if not Global.isDragging:
		canDrag = true
		scale = Vector2(1.05,1.05)


func _on_area_2d_mouse_exited():
	if not Global.isDragging:
		canDrag = false
		scale = Vector2(1,1)
