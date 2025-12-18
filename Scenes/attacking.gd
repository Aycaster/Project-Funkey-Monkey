extends State
class_name Attacking_State

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

func Enter():
	if Input.is_physical_key_pressed(KEY_E):
		sprite.play("Meg")
	if Input.is_physical_key_pressed(KEY_Q):
		sprite.play("Fire Blast")
	if Input.is_physical_key_pressed(KEY_F):
		sprite.play("Ice Blast")
	pass

func Exit():
	pass

func Update(_delta:float):
	if !sprite.is_playing():
		# Transition to Idle State
		state_transition.emit(self, "Idle")
