extends RobState
class_name Can_Control

# Called when the state is set to activate
func enter(_selected_state: RobState) -> void:
	pass

# Called when another state is to activate in order to clean up the previous one
func exit() -> void:
	pass

func physics_update(_delta) -> void:
	
	attack.attack()
	movement.get_dir()
	movement.move(_delta)
 
