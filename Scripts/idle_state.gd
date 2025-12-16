extends State
class_name Idle_State

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

func Enter():
	sprite.play("Idle")
	player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	pass
	
	
func Update(_delta:float):
	if(Input.get_axis("left","right")):
		#Transition to Running state
		state_transition.emit(self, "Running")
	if Input.is_action_just_pressed("down"):
		#Transition to Crouching state
		state_transition.emit(self, "Crouching")
	if !(player.is_on_floor()):
		#Transition to InAir state
		state_transition.emit(self, "InAir")
