extends Node


# Sends a signal whenever the state finishes and wants to transition
signal finished(next_state: String, data: Dictionary)

# Called by the state machine when recieving unhandled input events.
func handled_inputs(_events: InputEvent) -> void:
	pass

# Called by the state machine on the main engine loop tick.
func update(_delta: float) -> void:
	pass

# Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	pass

# Called by the state machine upon changing the active state. The `data` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state: String, data := {}) -> void:
	pass

# Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
