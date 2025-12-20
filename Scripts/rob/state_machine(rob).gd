extends Node
class_name state_machine

# Keeps all of the states in here
@export var states := {}
# State the character ctarts out with
@export var starting_state : RobState = null
# tracks current state and uses first child node if nothing is starting state
@onready var current_state : RobState = (func get_starting_state() -> RobState:
	return get_child(0) if starting_state == null else starting_state).call()

# Adds all of the states to the dictionary to store them for later use
func init(parent: Rob, animation: AnimatedSprite2D) -> void:
	for child in get_children():
		if child is RobState:
			states[child.name.to_lower()] = child
			child.statemachine = self
			child.animation = animation
			child.parent = parent
			child.request_transition.connect(transition_states)

# Transitions the states from the old to new one.
func transition_states(incoming_state: RobState):
	if incoming_state == current_state:
		return
	
	var previous_state := current_state
	current_state.exit()
	current_state = incoming_state
	current_state.enter(previous_state)

# Updates the states logic in the main game loop.
func _process(_delta):
	current_state.update(_delta)

# Same thing as _process but for the physics.
func _physics_process(_delta):
	current_state.physics_update(_delta)
