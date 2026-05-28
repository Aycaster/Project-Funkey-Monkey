extends State
class_name Idle_NPC_State

@onready var tyler : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = tyler.SPEED

func Enter():
	sprite.play("Idle_NPC")
	pass

func Exit():
	pass

func Update(_delta:float):
	if !sprite.is_playing():
		sprite.play("Idle_NPC")
	
	if tyler._fight_mode_on:
		state_transition.emit(self, "Chase_NPC")
