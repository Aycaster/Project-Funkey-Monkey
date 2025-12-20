extends CharacterBody2D
class_name Rob
@onready var animation = $AnimatedSprite2D
@onready var statemachine = $"State Machine"

# Variables to be used in the states and action scripts.
const base_speed = 100.0
const jump_velocity = -300.0

func _ready() -> void:
	statemachine.init(self, animation)

# Returns the direction of the player.
func get_dir() -> Vector2:

		var x = 0
		var y = 0

		if Input.is_physical_key_pressed(KEY_D):
			x += 1
		if Input.is_physical_key_pressed(KEY_A):
			x -= 1
		if Input.is_physical_key_pressed(KEY_W):
			y -= 1
		if Input.is_physical_key_pressed(KEY_S):
			y += 1

		return Vector2(x, y).normalized()

func _physics_process(_delta: float) -> void:
	
	var dir = get_dir()
	if dir.x > 0:
		animation.play("walk")
		animation.flip_h = false
		velocity.x = dir.x * base_speed
	if dir.x < 0:
		animation.play("walk")
		animation.flip_h = true
		velocity.x = dir.x * base_speed
	if statemachine.current_state == statemachine.states["ground state"]:
		if dir.y < 0:
			velocity.y = jump_velocity
	move_and_slide()
