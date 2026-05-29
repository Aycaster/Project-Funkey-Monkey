class_name Hitbox extends Area2D

var attacker_stats: Stats
var hitbox_lifetime: float
var shape: Shape2D
#note: add hitbox logging

var animated_sprite : AnimatedSprite2D
var watched_animation : String
var end_frame : int

func _init(_attacker_stats: Stats, _animated_sprite: AnimatedSprite2D, _watched_animation: String, _end_frame: int, _shape: Shape2D) -> void:
	attacker_stats = _attacker_stats
	animated_sprite = _animated_sprite
	watched_animation = _watched_animation
	end_frame = _end_frame
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
	
	match attacker_stats.faction:
		Stats.Faction.PLAYER:
			set_collision_mask_value(1, true)
		Stats.Faction.ENEMY:
			set_collision_mask_value(2, true)


func _process(_delta: float) -> void:
	if not animated_sprite:
		queue_free()
		return
		
	# Remove hitbox if animation changes
	if animated_sprite.animation != watched_animation:
		queue_free()
		return
		
	if animated_sprite.frame >= end_frame:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if not area.has_method("receive_hit"):
		return
	
	area.receive_hit(attacker_stats.damage)
	
	
	
