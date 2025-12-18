extends State
class_name Attacking_State

@onready var player : CharacterBody2D = $"../.."
@onready var sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var SPEED = player.SPEED

func Enter():
	sprite.play("Ice Blast")
	pass

func Exit():
	pass

func Update(_delta:float):
	var direction
	
	if !sprite.is_playing():
		state_transition.emit(self, "Idle")

	direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.animated_sprite.play("Idle")
