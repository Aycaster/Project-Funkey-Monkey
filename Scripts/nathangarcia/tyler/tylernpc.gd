extends CharacterBody2D
class_name Tyler

@export var stats : Stats
@export var SPEED := 200.0
@export var JUMP_VELOCITY := -200.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var player = $"../Nathan"
@onready var tyler = $"."
@onready var direction : float = 0.0
@onready var is_alive : bool = true
@onready var _fight_mode_on : bool = false
@export var hitbox_shape : Shape2D
@onready var healthbar = $Healthbar

@onready var position_offset : float
@onready var PlyrPOS : float
@onready var PlyrYPOS : float


var hitbox = null

func _ready():
	healthbar.init_health(stats)

func _physics_process(delta: float) -> void:
	position_offset = abs(player.position.x - tyler.position.x)
	PlyrPOS = tyler.position.x - player.position.x
	PlyrYPOS = player.position.y
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()
	
	print(stats.health)

func _jump() -> void:
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func _go_left() -> void:
	animated_sprite.position.x = 0
	animated_sprite.flip_h = false
	velocity.x = -1 * SPEED

func _go_right() -> void:
	animated_sprite.flip_h = true
	animated_sprite.position.x = 75
	position_offset += 75
	velocity.x = SPEED

func _attack() -> void:
	animated_sprite.play("Attack")
	if animated_sprite.animation == "Attack":
		if animated_sprite.frame == 4:
			if not is_instance_valid(hitbox):
				hitbox = Hitbox.new(stats, animated_sprite, "Attack", 6, hitbox_shape)
				hitbox.position.y = 10
				if animated_sprite.flip_h:
					hitbox.position.x = 99
				else:
					hitbox.position.x = -25
				add_child(hitbox)
