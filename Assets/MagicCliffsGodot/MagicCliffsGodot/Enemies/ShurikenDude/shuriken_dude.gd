extends Area2D

var enemy_visible_flag = false

func throw_shuriken():
	# only spawn a shuriken if the enemy is visible on screen
	if enemy_visible_flag:		
		var scene_to_spawn = preload("res://Enemies/ShurikenDude/Shuriken/shuriken.tscn")
		var new_scene_instance = scene_to_spawn.instantiate()
		new_scene_instance.global_position = $ThrowPosition.global_position 
		get_tree().current_scene.add_child(new_scene_instance)  # Add the instance as a child of the current scene



func _on_visible_on_screen_notifier_2d_screen_entered():
	enemy_visible_flag = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	enemy_visible_flag = false
