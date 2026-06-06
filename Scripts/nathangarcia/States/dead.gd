extends State
class_name Dead_State

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED
@onready var fsm = $".."


func Enter():
	player.is_alive = false
	sprite.play("Dead")
	
	
func Exit():
	player.is_alive = true
	player.stats.health = 100


func Update(_delta:float):
# State Transitions Conditions
	if Input.is_physical_key_pressed(KEY_R):
		#Transition to Idle state
		state_transition.emit(self, "Idle")
	
