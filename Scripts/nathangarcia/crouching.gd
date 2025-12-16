extends State
class_name Crouching_State

@onready var player : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

# Called when the node enters the scene tree for the first time.
func Enter():
	animated_sprite.play("Crouching")
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	var direction = player.direction
	
	if direction:
		state_transition.emit(self, "CrouchWalk")
	
	if(!(Input.is_action_pressed("down"))):
		#Transition to Idle state
		player.velocity.x = direction * SPEED
		state_transition.emit(self, "Idle")
