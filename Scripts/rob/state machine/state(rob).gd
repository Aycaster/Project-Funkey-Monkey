extends Node
class_name RobState

var parent : Rob
var attack : Attack
var movement : Movement_Rob
var statemachine : State_Machine

# Used to ask whether or not the state can transition
signal request_transition(next_state: RobState)

# Called when the state is set to activate
func enter(_selected_state: RobState) -> void:
	pass

# Called when another state is to activate in order to clean up the previous one
func exit() -> void:
	pass

func physics_update(_delta) -> void:
	pass
