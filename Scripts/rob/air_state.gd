extends RobState
class_name AirState

func enter(_selected_state: RobState) -> void:
	animation.play("idle")

func update(_delta: float) -> void:
	pass
	"""if parent.is_on_floor():
		request_transition.emit(statemachine.states["ground states"])"""

func physics_update(_delta: float) -> void:
	parent.velocity.y = parent.jump_velocity

func can_use_action(action_list) -> void:
	for action in action_list:
		var type = action_list[action]
		if type == RobState:
			action
