extends CharacterBody2D
class_name Rob
@onready var animation = $"AnimatedSprite2D"
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

		if Input.is_action_pressed("right"):
			x += 1
		if Input.is_action_pressed("left"):
			x -= 1
		if Input.is_action_pressed("up"):
			y -= 1
		if Input.is_action_pressed("down"):
			y += 1

		return Vector2(x, y).normalized()

func _physics_process(_delta: float) -> void:
	
	var dir = get_dir()
