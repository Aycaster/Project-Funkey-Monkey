extends State
class_name Crouching_State

@onready var player : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"

# Called when the node enters the scene tree for the first time.
func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	if(!(Input.is_action_pressed("crouch"))):
		#Transition to Running state
		state_transition.emit(self, "Idle_State")
	if (Input.get_axis("left","right")):
		#Transition to Crouching state
		state_transition.emit(self, "Running_State")
