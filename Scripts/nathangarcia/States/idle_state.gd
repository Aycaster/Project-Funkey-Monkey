extends State
class_name Idle_State

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

func Enter():
	sprite.play("Idle")
	pass
	

func Update(_delta:float):
	if !sprite.is_playing():
		sprite.play("Idle")

# State Transitions Conditions
	if(Input.get_axis("left","right")):
		#Transition to Running state
		state_transition.emit(self, "Running")
	if Input.is_action_just_pressed("down"):
		#Transition to Crouching state
		state_transition.emit(self, "Crouching")
	if !(player.is_on_floor()):
		#Transition to InAir state
		state_transition.emit(self, "InAir")
	if Input.is_physical_key_pressed(KEY_E) || Input.is_physical_key_pressed(KEY_Q) || Input.is_physical_key_pressed(KEY_F):
		state_transition.emit(self, "Attacking")
