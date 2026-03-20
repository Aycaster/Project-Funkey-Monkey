extends AnimatedSprite2D
class_name RobAnimation

var desc : Descriptor

func animator() -> void:
	if desc.current_attack == "None":
		play(desc.current_movement)
		flip_h = desc.facing
		
		if animation != desc.current_movement:
			assert(false, "this an animation is not matching with the current movement or doesn't exist")
	else:
		play(desc.current_attack)
		if animation != desc.current_attack:
			assert(false, "this an animation is not matching with the current attack or doesn't exist")
