extends State
class_name InAir_State

@onready var player : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

# Called when the node enters the scene tree for the first time.
func Enter():
	animated_sprite.play("In Air")
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	var direction = player.direction
	if direction:
		player.velocity.x = direction * SPEED
		animated_sprite.flip_h = player.direction < 0
	
	if player.is_on_floor():
		#Transition to Running state
		state_transition.emit(self, "Idle")
