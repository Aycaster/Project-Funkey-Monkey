extends CharacterBody2D
class_name nathangarcia

@export var stats : Stats
@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0

@onready var healthbar = $Healthbar
@onready var animated_sprite = $AnimatedSprite2D
@onready var direction : float = 0.0
@onready var is_alive : bool = true

@export var hitbox_shape: Shape2D

func _ready():
	healthbar.init_health(stats.health)

func _physics_process(delta: float) -> void:
	if is_alive:
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
	


func _update_health(value) -> void:
	stats.health = value
	healthbar.health = stats.health
	if stats.health <= 0 && is_alive:
		is_alive = false

func _summon_hitbox(_attacktype : float, _attackshape : Shape2D) -> void:
	var hitbox = Hitbox.new(stats, _attacktype, _attackshape)
	if Input.is_key_pressed(KEY_Q):
		hitbox.scale.x = 8
		hitbox.scale.y = 5
		hitbox.position.x = 4.0
		hitbox.position.y = -14.0
	if Input.is_key_pressed(KEY_F):
		hitbox.position.x = 65
		hitbox.position.y = -25
		hitbox.scale.x = 4
	add_child(hitbox)
