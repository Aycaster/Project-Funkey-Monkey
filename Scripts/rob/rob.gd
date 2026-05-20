extends CharacterBody2D
class_name Rob

@onready var animation = $AnimatedSprite2D
@onready var statemachine = $"State Machine"

var input = Input_Rob.new()
var descriptor = Descriptor.new()
var attack = Attack.new()
var movement = Movement_Rob.new()
var stats = Stats.new()

@export var hitbox_shape: Shape2D

# Variables to be used in the states and action scripts.
const gravity := 1000
const base_speed := 100.0
const jump_velocity := -300.0

func _ready() -> void:
	
	attack.init(self, movement, descriptor, animation, hitbox_shape, stats)
	animation.init(descriptor)
	movement.init(self, descriptor, attack)
	statemachine.init(self, movement, attack)

func _process(_delta: float) -> void:
	
	Debug_Console.look("player direction", movement.get_dir())
	Debug_Console.look("player velocity", velocity)
	Debug_Console.look("current state", statemachine.current_state)
	Debug_Console.look("current movement", descriptor.current_movement)
	Debug_Console.look("current attack", descriptor.current_attack)
	Debug_Console.look("attack buffer", attack.attack_executed)
	
	movement.get_dir()
	animation.animator()

func _physics_process(delta: float) -> void:
	
	movement.gravity(delta)
	move_and_slide()
