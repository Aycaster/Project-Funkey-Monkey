extends Area2D
class_name Hurt_Box

@onready var owner_stats: Stats = owner.stats

func _ready() -> void:
	monitoring = false
	
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	match owner_stats.Type:
		Stats.Type.Player:
			set_collision_layer_value(2, true)
		Stats.Type.Enemy:
			set_collision_layer_value(1, true)
			

func recieve_hit(damage: int) -> void:
	owner_stats.take_damage(damage)
