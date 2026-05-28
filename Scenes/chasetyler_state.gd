extends State
class_name Chase_NPC_State

@onready var tyler : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = tyler.SPEED
@onready var player : CharacterBody2D = $"."

var position_offset = abs(player.position.x - tyler.position.x)
var PlyrPOS = player.position.x - tyler.position.x

func Enter():
	sprite.play("Chase_NPC")
	pass

func Exit():
	pass

func Update(_delta:float):
	var direction = tyler.direction
	if direction:
		#tyler.velocity.x = direction * SPEED
		sprite.play("Chase_NPC")
		sprite.flip_h = tyler.direction < 0
		
	
	
	
	
	# Conditions for switching states
	if(!(Input.get_axis("left","right"))):
		#Transition to Idle state
		state_transition.emit(self, "Idle")
	if Input.is_action_just_pressed("down"):
		#Transition to Crouching state
		#tyler.velocity.x = move_toward(tyler.velocity.x, 0, SPEED)
		state_transition.emit(self, "Crouching")
	if !(tyler.is_on_floor()):
		#Transition to InAir state
		state_transition.emit(self, "InAir")
	if Input.is_physical_key_pressed(KEY_E) || Input.is_physical_key_pressed(KEY_Q) || Input.is_physical_key_pressed(KEY_F):
		state_transition.emit(self, "Attacking")
