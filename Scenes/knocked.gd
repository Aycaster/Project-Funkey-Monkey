extends State
class_name Knocked

@onready var tyler : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = tyler.SPEED
@onready var player = $"."


func Enter():
	sprite.play("Knock")
	pass

func Exit():

	pass

func Update(_delta:float):
	#if tyler.position_offset > 50 && !sprite.is_playing():
	if !sprite.is_playing():
		state_transition.emit(self, "Chase_NPC")
	else:
		tyler._attack()
	if tyler.stats.health <= 0:
		state_transition.emit(self, "Dead")
