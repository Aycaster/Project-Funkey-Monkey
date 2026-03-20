extends CharacterBody2D
class_name Rob
@onready var descriptor = $Descriptor
@onready var animation = $AnimatedSprite2D
@onready var statemachine = $"State Machine"
@onready var attack = $Attack
@onready var movement = $Movement

# Variables to be used in the states and action scripts.
const gravity := 1000
const base_speed := 100.0
const jump_velocity := -300.0

func _ready() -> void:
	
	animation.desc = descriptor
	
	attack.parent = self
	attack.move = movement
	attack.desc = descriptor
	attack.anim = animation
	
	movement.descriptor = descriptor
	movement.attack = attack
	movement.parent = self
	
	statemachine.init(self, movement, attack)

func _process(delta: float) -> void:
	
	Debug_Console.look("player direction", movement.get_dir())
	Debug_Console.look("player velocity", velocity)
	Debug_Console.look("current state", statemachine.current_state)
	Debug_Console.look("current movement", descriptor.current_movement)
	Debug_Console.look(("current attack"), descriptor.current_attack)
	Debug_Console.look(("attack buffer"), attack.attack_executed)
	
	animation.animator()

func _physics_process(delta: float) -> void:
	
	movement.gravity(delta)
	move_and_slide()
