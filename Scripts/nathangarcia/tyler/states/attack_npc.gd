extends State
class_name Attack_NPC_State

@onready var tyler : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = tyler.SPEED
@onready var player = $"."


func Enter():
	tyler._attack()
	pass

func Exit():
	pass

func Update(_delta:float):
	if tyler.position_offset > 50 && !sprite.is_playing():
		state_transition.emit(self, "Chase_NPC")
	else:
		tyler._attack()
