extends State
class_name Dead

@onready var tyler : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = tyler.SPEED
@onready var player = $"."


func Enter():
	sprite.play("Death")

func Exit():
	tyler.stats.health = 100
	tyler._ready()

func Update(_delta:float):
	if Input.is_physical_key_pressed(KEY_0):
		state_transition.emit(self, "Idle_NPC")
