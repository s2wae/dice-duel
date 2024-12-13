class_name FiniteStateMachine
extends Node


var states : Dictionary = {}
var current_state : State
@export var initial_state : State
@export var parent_node : Area2D


func _ready():
	parent_node = get_parent()
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)

	if initial_state:
		initial_state.enter()
		current_state = initial_state



func _process(delta):
	if current_state:
		current_state.update(delta)
		
		# Using this to check state of current enemy
	#if parent_node.is_in_group("enemy"):
		#print(current_state)
	#if parent_node.is_in_group("units"):
		#print(current_state)



func force_change_state(new_state : String):
	var newState = states.get(new_state.to_lower())
	
	if !newState:
		print(new_state + " does not exist in the dictionary of states")
		return
	
	if current_state == newState:
		print("State is same, aborting")
		return
		

	if current_state:
		var exit_callable = Callable(current_state, "Exit")
		exit_callable.call_deferred()
	
	newState.enter()
	
	current_state = newState


func change_state(source_state : State, new_state_name : String):
	if source_state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state
