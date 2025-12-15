extends State
class_name Idle_State

@export var sprite : AnimatedSprite2D

func Enter():
	sprite.play("Idle")
	pass
	
	
func Update(_delta:float):
	if(Input.get_axis("left","right")):
		#Transition to Running state
		state_transition.emit(self, "Running")
	if Input.is_action_just_pressed("down"):
		#Transition to Crouching state
		state_transition.emit(self, "Crouching")
	if Input.is_action_just_pressed("up"):
		#Transition to InAir state
		state_transition.emit(self, "InAir_State")
