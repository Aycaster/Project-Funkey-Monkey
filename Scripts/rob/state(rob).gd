extends Node
class_name RobState

var animation: AnimatedSprite2D
var parent: Rob
var statemachine: state_machine

# Used to ask whether or not the state can transition
signal request_transition(next_state: RobState)

# Called when the state is set to activate
func enter(_selected_state: RobState) -> void:
	pass

# Called when another state is to activate in order to clean up the previous one
func exit() -> void:
	pass

# Used when in the engines main loop tick
func update(_delta: float) -> void:
	pass

# Used for the main engine physics update tick
func physics_update(_delta: float) -> void:
	pass

# Checks to see if the ability is allowed to be used in the current state
# defualt policy is true for the time being
func can_use_action(_action_list: Array) -> void:
	pass
