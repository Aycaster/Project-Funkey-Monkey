extends Node
class_name Movement_Rob

var parent : Rob
var descriptor : Descriptor
var attack : Attack

var input_list = {}
var comp_inputs = {"burst_dash": {"inputs": []}}

const experation = 30
const base_inputs = {"Left": "KEY_A", "Right": "KEY_D", "Up": "KEY_W", "Down": "KEY_S", "Secondary Input": "KEY_F"}

# Returns the direction of the player.
func get_dir() -> Vector2:

	var x = 0
	var y = 0

	if Input.is_action_pressed("Move Right"):
		x += 1
	if Input.is_action_pressed("Move Left"):
		x -= 1
	if Input.is_action_pressed("Move Up"):
		y -= 1
	if Input.is_action_pressed("Move Down"):
		y += 1

	return Vector2(x, y).normalized()

# Used to handle the basic movement functions.
func move(_delta: float) -> void:
	
	if get_dir().x != 0:
		if not Input.is_action_pressed("Secondary Input"):
			descriptor.current_movement = "walk"
			parent.velocity.x = get_dir().x * descriptor.max_speed
		elif Input.is_action_pressed("Secondary Input"):
			descriptor.current_movement = "run"
			parent.velocity.x = get_dir().x * descriptor.max_speed * 2
	else:
		parent.velocity.x = 0
	
	if get_dir().x < 0:
		descriptor.facing = true
	elif get_dir().x > 0:
		descriptor.facing = false
	
	if get_dir().y < 0 and parent.is_on_floor():
		parent.velocity.y = descriptor.jump_velocity
	if parent.velocity.y < 0:
		descriptor.current_movement = "jump"
	if parent.velocity.y > 0:
		descriptor.current_movement = "falling"
	
	if parent.velocity == Vector2(0, 0):
		descriptor.current_movement = "idle"

# Players gravity
func gravity(_delta:float) -> void:
	
	if not parent.is_on_floor():
		parent.velocity.y += parent.gravity * _delta

# incomplete for now
"""func input_buffer() -> void:
	
	var current_time = Time.get_ticks_msec()
	
	for key in base_inputs:
		if Input.is_physical_key_pressed(key):
			input_list[key.key] = Time.get_ticks_msec()"""
