extends Node
class_name RobState

# Used to ask whether or not the state can transition
signal request_transition

# Called when the state is set to activate
func enter(selected_state: RobState) -> void:
	pass

# Called when another state is to activate in order to clean up the previous one
func exit() -> void:
	pass

# Used when in the engines main loop tick
func update(delta: float) -> void:
	pass

# Used for the main engine physics update tick
func physics_update(delta: float) -> void:
	pass

# Checks to see if the ability is allowed to be used in the current state
# defualt policy is true for the time being
func can_use_action(action_id: String, current_state: RobState) -> void:
	pass
