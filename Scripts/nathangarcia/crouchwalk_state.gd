extends State
class_name CrouchWalk_State

@onready var player : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

# Called when the node enters the scene tree for the first time.
func Enter():
	animated_sprite.play("Crouch Crawl")
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	var direction = player.direction # Direction is either -1,1 (left, right)
	if direction:
		animated_sprite.flip_h = player.direction < 0
	
	if direction == 0: # 0 means not left or right
		state_transition.emit(self, "Crouching") 
		
	
	if(!(Input.is_action_pressed("down"))): 
		#Transition to Idle state
		state_transition.emit(self, "Idle")
	if Input.is_physical_key_pressed(KEY_E) || Input.is_physical_key_pressed(KEY_Q) || Input.is_physical_key_pressed(KEY_F):
		state_transition.emit(self, "Attacking")
