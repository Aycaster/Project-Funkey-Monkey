extends State
class_name Running_State

@onready var player : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"

@onready var SPEED = player.SPEED
# Called when the node enters the scene tree for the first time.
func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	var direction = player.direction
	if direction:
		player.velocity.x = direction * SPEED
		animated_sprite.play("Running")
		animated_sprite.flip_h = player.direction < 0
	else:
		player.velocity.x = player.move_toward(player.velocity.x, 0, SPEED)
		
		
	
	if(!(Input.get_axis("left","right"))):
		#Transition to Running state
		state_transition.emit(self, "Idle_State")
	if Input.is_action_just_pressed("down") && player.is_on_floor():
		#Transition to Crouching state
		state_transition.emit(self, "Crouching_State")
	if !(player.is_on_floor()):
		#Transition to InAir state
		state_transition.emit(self, "InAir_State")
