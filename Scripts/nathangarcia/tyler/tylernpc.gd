extends CharacterBody2D
class_name Tyler

@export var stats : Stats
@export var SPEED := 300.0
@export var JUMP_VELOCITY := -200.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = $"../Nathan"
@onready var tyler = $"."
@onready var direction : float = 0.0
@onready var is_alive : bool = true
@onready var _fight_mode_on : bool = false
@export var hitbox_shape : Shape2D

@onready var position_offset : float
@onready var PlyrPOS : float

func _physics_process(delta: float) -> void:
	position_offset = abs(player.position.x - tyler.position.x)
	PlyrPOS = tyler.position.x - player.position.x
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	move_and_slide()


func _jump() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func _go_left() -> void:
	animated_sprite.flip_h = false
	velocity.x = -1 * SPEED

func _go_right() -> void:
	animated_sprite.flip_h = true
	velocity.x = SPEED
	
func _attack() -> void:
	animated_sprite.play("Attack")
	if animated_sprite.animation == "Attack":
		if animated_sprite.frame == 4:
			var hitbox = Hitbox.new(stats, animated_sprite, "Attack", 6, hitbox_shape)
			hitbox.position.x = -35
			hitbox.position.y = 10
			add_child(hitbox)
	
	
	
