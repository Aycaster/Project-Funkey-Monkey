extends State
class_name Crouching_State

@onready var player : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

# Called when the node enters the scene tree for the first time.
func Enter():
	animated_sprite.play("Crouching")
	pass
	
func Exit():
	pass
	
func Update(_delta:float):
	animated_sprite.play("Crouching")
	var direction = player.direction
	if direction:
		player.velocity.x = direction * (SPEED / 2)
		animated_sprite.play("Crouch Crawl")
		animated_sprite.flip_h = player.direction < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
	
	
	if(!(Input.is_action_pressed("down"))):
		#Transition to Idle state
		player.SPEED = 300.0
		state_transition.emit(self, "Idle")
