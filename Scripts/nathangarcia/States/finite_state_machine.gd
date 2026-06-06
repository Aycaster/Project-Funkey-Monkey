extends Node
class_name FiniteStateMachine

var states: Dictionary = {}
var  current_state : State
@export var initial_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
			
		if initial_state:
			initial_state.Enter()
			current_state = initial_state

func change_state(source_state : State, new_state_name : String):
	if source_state != current_state:
		print("Invalid change_state trying from: " + source_state.name + " but currently in:" + current_state.name)
		return

	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("New state is empty")
		return
	
	if current_state:
		current_state.Exit()
		
	print("Successfully changed state from " + current_state.name + " to " + new_state_name)
	
	new_state.Enter()
	
	current_state = new_state

func _process(delta):
	if current_state:
		current_state.Update(delta)


func force_change_state(new_state: String):
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

	newState.Enter()
	current_state = newState
