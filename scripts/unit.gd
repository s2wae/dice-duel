extends Node2D

@onready var boardSlot = preload("res://scenes/board_slot.tscn")

var canDrag = false
var isInDropArea = false
var isInSellArea = false
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
			if isInDropArea and curBoardSlot.curState == Global.slotState.FREE:
				position = bodyRef.position + Vector2(75,75)
				if Input.is_action_just_released('lmb'):
					print("DISABLED")
					curBoardSlot.curState = Global.slotState.USED
			elif isInSellArea:
				if Input.is_action_just_released('lmb'):
					queue_free()
			else:
				global_position = initialPos



func _on_area_2d_area_entered(area):
	if area.is_in_group('droppable'):
		curBoardSlot = area.get_node("..")
		print(curBoardSlot.curState)
		isInDropArea = true
		bodyRef = area
		self.reparent(area)
	if area.is_in_group('sell'):
		isInSellArea = true



func _on_area_2d_area_exited(area):
	if(!area.has_overlapping_areas()):
		if area.is_in_group('droppable'):
			curBoardSlot.curState = Global.slotState.FREE
			print(curBoardSlot.curState)
			print("OUT DROP AREA")
			isInDropArea = false
	if area.is_in_group('sell'):
		isInSellArea = false



func _on_area_2d_mouse_entered():
	if not Global.isDragging:
		canDrag = true
		scale = Vector2(1.05,1.05)


func _on_area_2d_mouse_exited():
	if not Global.isDragging:
		canDrag = false
		scale = Vector2(1,1)
