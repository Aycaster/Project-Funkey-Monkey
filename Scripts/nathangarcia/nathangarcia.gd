extends CharacterBody2D
class_name nathangarcia

@export var stats : Stats
@export var SPEED := 300.0
@export var JUMP_VELOCITY := -400.0

@onready var healthbar = $Healthbar
@onready var animated_sprite = $AnimatedSprite2D
@onready var direction : float = 0.0
@onready var is_alive : bool = true
@onready var end_frame: int


@export var hitbox_shape: Shape2D

func _ready():
	healthbar.init_health(stats)

func _physics_process(delta: float) -> void:
	#print(stats.health)
	if stats.health <= 0:
		is_alive = false

	if is_alive:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		direction = Input.get_axis("left", "right")
		if direction:
			if Input.is_action_pressed("down"): # Speed when crouch
				velocity.x = direction * (SPEED / 2)
			else:
				velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		_summon_hitbox()


"""func _update_health(value) -> void:
	print("update health is running")
	stats.health = value
	healthbar.health = stats.health
	if stats.health <= 0 && is_alive:
		is_alive = false"""

func _summon_hitbox() -> void: #function to create a hitbox based on attack
	#this function runs in delta, constantly checks to see if the attack 
	#animation has started. If it has, then it creates the hitbox for that 
	#attack based on what frame the animation is in at the time. 
	#Then it alters the position of the hitbox to match the in game animation
	
	
	if animated_sprite.animation == "Ice Blast" || animated_sprite.animation == "Fire Blast":
		end_frame = 3
		if animated_sprite.frame == 1:
			if animated_sprite.animation == "Fire Blast": # Fire Attack doesn't need to be altered based on direction since it's an AOE attack
				var hitbox = Hitbox.new(stats, animated_sprite,"Fire Blast", end_frame, $Meg.shape)
				hitbox.scale.x = 8
				hitbox.scale.y = 5
				hitbox.position.x = 4.0
				hitbox.position.y = -14.0
				add_child(hitbox)
			if animated_sprite.animation == "Ice Blast": # Ice Attack 
				var hitbox = Hitbox.new(stats, animated_sprite,"Ice Blast", end_frame, $Ice.shape)
				if !animated_sprite.flip_h: #checks to see which direction the hitbox should be created. 
					hitbox.position.x = 65
					hitbox.position.y = -25
					hitbox.scale.x = 4
				else:
					hitbox.position.x = -65
					hitbox.position.y = -25
					hitbox.scale.x = 4
				add_child(hitbox)

	if animated_sprite.animation == "Meg":
		end_frame = 2
		if animated_sprite.frame == 1:
			var hitbox = Hitbox.new(stats, animated_sprite, "Meg", end_frame, $Meg.shape)
			if !animated_sprite.flip_h:
				hitbox.position.x = 40
				hitbox.position.y = -15
				hitbox.scale.x = 2
				hitbox.rotate(3)
			else:
				hitbox.position.x = -40
				hitbox.position.y = -15
				hitbox.scale.x = -2
				hitbox.rotate(-3)
			add_child(hitbox)
