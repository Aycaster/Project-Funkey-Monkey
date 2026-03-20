extends Node
class_name State_Machine

# Keeps all of the states in here
@export var states := {}
# State the character ctarts out with
@export var starting_state : RobState = null
# tracks current state and uses first child node if nothing is starting state
@onready var current_state : RobState = (func get_starting_state() -> RobState:
	return get_child(0) if starting_state == null else starting_state).call()

# Adds all of the states to the dictionary to store them for later use
func init(parent: Rob, movement: Movement_Rob, attack: Attack) -> void:
	for child in get_children():
		if child is RobState:
			states[child.name.to_lower()] = child
			child.attack = attack
			child.parent = parent
			child.movement = movement
			child.statemachine = self
			child.request_transition.connect(transition_states)

# Transitions the states from the old to new one.
func transition_states(incoming_state: RobState):
	if incoming_state == current_state:
		return
	
	var previous_state := current_state
	current_state.exit()
	current_state = incoming_state
	current_state.enter(previous_state)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
