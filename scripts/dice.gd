extends Node2D


@onready var diceSlot = preload("res://scenes/dice_slot.tscn")

var canDrag = false
var isInDropArea = false
var isInSellArea = false
var curBoardSlot
var initialPos
var bodyRef


func _ready():
	pass # Replace with function body.


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
			elif isInSellArea:
				if Input.is_action_just_released('lmb'):
					queue_free()
					Global.goldCount += 1
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)


func _on_area_2d_area_entered(area):
	bodyRef = area
	if area.is_in_group('sell'):
		isInSellArea = true


func _on_area_2d_mouse_entered():
	if not Global.isDragging:
		canDrag = true
		scale = Vector2(1.05,1.05)


func _on_area_2d_mouse_exited():
	if not Global.isDragging:
		canDrag = false
		scale = Vector2(1,1)
