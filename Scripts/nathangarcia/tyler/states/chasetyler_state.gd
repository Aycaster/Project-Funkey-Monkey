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
	

	
	#Follows the player based on if they are on the left or right
	if tyler.PlyrPOS < -3:
		tyler._go_right()
		
	if tyler.PlyrPOS > 0:
		tyler._go_left()
	
	#Handles Jumps
	if tyler.PlyrYPOS < tyler.position.y:
		tyler._jump()
	
	if tyler.PlyrPOS < 50 and tyler.PlyrPOS > -125:
		state_transition.emit(self, "Attack_NPC")
