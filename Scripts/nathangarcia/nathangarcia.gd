extends CharacterBody2D
class_name nathangarcia


@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var direction : float = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction:
		if Input.is_action_pressed("down"): # Speed when crouch
			velocity.x = direction * (SPEED / 2)
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
