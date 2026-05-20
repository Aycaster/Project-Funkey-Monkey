extends Area2D
class_name HitBox

var attacker_stats: Stats
var shape: Shape2D
#note: add hitbox logging


func _init(_attacker_stats: Stats, _shape: Shape2D) -> void:
	attacker_stats = _attacker_stats
	shape = _shape
	
func _ready() -> void:
	monitorable = false
	area_entered.connect(_on_area_entered)
		
	if shape:
		var collision_shape = CollisionShape2D.new()
		collision_shape.shape = shape
		add_child(collision_shape)
		
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	match attacker_stats.Type:
		Stats.Type.Player:
			set_collision_mask_value(2, true)
		Stats.Type.Enemy:
			set_collision_mask_value(1, true)


func _on_area_entered(area: Area2D) -> void:
	if not area.has_method("recieve_hit"):
		return
	
	area.recieve_hit(attacker_stats.damage)
