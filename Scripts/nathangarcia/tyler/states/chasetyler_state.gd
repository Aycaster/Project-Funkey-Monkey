extends State
class_name Chase_NPC_State

@onready var tyler : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = tyler.SPEED
@onready var player = $"."


func Enter():
	sprite.play("Chase")
	pass

func Exit():
	pass

func Update(_delta:float):
	sprite.play("Chase")
	
	print(tyler.PlyrPOS)
	if tyler.PlyrPOS < 0:
		print("going right")
		tyler._go_right()
	if tyler.PlyrPOS > 0:
		print("going left")
		tyler._go_left()
	
	if tyler.position_offset < 50:
		state_transition.emit(self, "Attack_NPC")
		
	
	
