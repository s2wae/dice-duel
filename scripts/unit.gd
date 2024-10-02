extends Node2D

var canDrag = false
var isInDropArea = false
var initialPos
var bodyRef
var offset

func _ready():
	pass


func _process(delta):
	
	if canDrag:
		if Input.is_action_just_pressed("mdown"):
			initialPos = global_position
			Global.isDragging = true
		if Input.is_action_pressed("mdown"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("mdown"):
			Global.isDragging = false
			var tween = get_tree().create_tween()
			if isInDropArea:
				tween.tween_property(self, "position", bodyRef.global_position + Vector2(75,75), .2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)


func _on_area_2d_area_entered(area):
	if area.is_in_group('droppable'):
		isInDropArea = true
		print("IN DROP AREA")
		bodyRef = area



func _on_area_2d_area_exited(area):
	if area.is_in_group('droppable'):
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
