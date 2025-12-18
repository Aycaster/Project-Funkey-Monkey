extends State
class_name InAir_State

@onready var player : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite.play("In Air")
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	var direction = player.direction
	if direction:
		animated_sprite.flip_h = player.direction < 0

	if player.is_on_floor():
		#Transition to Running state
		state_transition.emit(self, "Idle")
	if Input.is_physical_key_pressed(KEY_E) || Input.is_physical_key_pressed(KEY_Q) || Input.is_physical_key_pressed(KEY_F):
		state_transition.emit(self, "Attacking")
