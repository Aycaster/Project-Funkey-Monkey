extends RobState
class_name GroundState

# 
func enter(_selected_state: RobState) -> void:
	animation.play("idle")

func exit() -> void:
	pass

func update(_delta: float) -> void:
	if not parent.is_on_floor():
		request_transition.emit(statemachine.states["air state"])

func physics_update(_delta: float) -> void:
	parent.velocity.x = 0

func can_use_action(action_list) -> void:
	for action in action_list:
		var type = action_list[action]
		if type == RobState:
			action
