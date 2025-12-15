extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
enum state {idle, walk_left, walk_right, run_left, run_right, jump, land, crouch}
var current_state: state = state.idle

@onready var animated_sprite = $AnimatedSprite2D

func get_dir() -> Vector2:
		
		var x = 0
		var y = 0
		
		if Input.is_action_pressed("right"):
			x += 1
		if Input.is_action_pressed("left"):
			x -= 1
		if Input.is_action_pressed("up"):
			y -= 1
		if Input.is_action_pressed("down"):
			y += 1
		
		return Vector2(x, y).normalized()

func _physics_process(delta: float) -> void:
	
	# Variables to use below
	get_dir()
	var x = get_dir().x
	var y = get_dir().y
	current_state = state.idle
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handles the movement events.
	if x > 0 and Input.is_action_pressed("secondary key"):
		current_state = state.run_right
	elif x > 0:
		current_state = state.walk_right
	if x < 0 and Input.is_action_pressed("secondary key"):
		current_state = state.run_left
	elif x < 0 :
		current_state = state.walk_left
	if y < 0 and is_on_floor():
		current_state = state.jump
	if y > 0: 
		current_state = state.crouch
		
	
	# Handles the actual effects of given state.
	if current_state == state.idle:
		animated_sprite.play("idle")
		velocity.x = 0
	if current_state == state.walk_right:
		animated_sprite.play("walk")
		animated_sprite.flip_h = false
		velocity.x = SPEED
	if current_state == state.run_right:
		animated_sprite.play("run")
		animated_sprite.flip_h = false
		velocity.x = 2 * SPEED
	if current_state == state.walk_left:
		animated_sprite.play("walk")
		animated_sprite.flip_h = true
		velocity.x = -SPEED
	if current_state == state.run_left:
		animated_sprite.play("run")
		animated_sprite.flip_h = true
		velocity.x = 2 * -SPEED
	if current_state == state.jump:
		animated_sprite.play("jump")
		velocity.y = JUMP_VELOCITY
	if current_state == state.crouch:
		pass
	
	

	move_and_slide()
