extends State
class_name Attacking_State

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

@onready var meg_shape : Shape2D = $"../../Meg".shape
@onready var fire_shape : Shape2D = $"../../Fire".shape
@onready var ice_shape : Shape2D = $"../../Ice".shape

func Enter():
	if Input.is_physical_key_pressed(KEY_E):
		sprite.play("Meg")
		player._summon_hitbox(.08,meg_shape)
	if Input.is_physical_key_pressed(KEY_Q):
		sprite.play("Fire Blast")
		player._summon_hitbox(.13,meg_shape)
	if Input.is_physical_key_pressed(KEY_F):
		sprite.play("Ice Blast")
		player._summon_hitbox(.24,ice_shape)
	pass

func Exit():
	pass

func Update(_delta:float):
	if !sprite.is_playing():
		# Transition to Idle State
		state_transition.emit(self, "Idle")
