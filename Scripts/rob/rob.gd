extends CharacterBody2D
class_name Rob

const speed = 100.0
const jump_velocity = -300.0

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
