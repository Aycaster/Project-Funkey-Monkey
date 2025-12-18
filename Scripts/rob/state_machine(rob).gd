extends Node
class_name state_machine

var character : Rob
var starting_state : RobState = null
var current_state : RobState = (func get_starting_state() -> RobState:
	return get_child(0) if starting_state == null else starting_state).call()
var states := {}

func _ready() -> void:
	for child in get_children():
		if child is RobState:
			states[child.name.to_lower()] = child
			child.character = character
			child.request_transition.connect(transition_states)

func transition_states(incoming_state: RobState):
	if incoming_state == current_state:
		return
	
	var previous_state := current_state
	current_state.exit()
	current_state = incoming_state
	current_state.enter(previous_state)

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)
