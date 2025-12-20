extends State
class_name Dead_State

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

var is_dead = false

func Enter():
	player.SPEED = 0
	sprite.play("Dead")

func Update(_delta:float):
	if !sprite.is_playing():
		sprite.play("Idle")

# State Transitions Conditions
	if Input.is_physical_key_pressed(KEY_R):
		#Transition to Idle state
		state_transition.emit(self, "Idle")

func _die():
	if(is_dead):
		return
		
	is_dead = true
