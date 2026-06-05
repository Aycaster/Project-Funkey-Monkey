class_name Healthbar extends ProgressBar

@onready var timer = $Timer
@onready var damage_bar = $Damagebar

var stats : Stats

func _set_health(new_health):
	print("is this on?")
	var prev_health = value 
	value = min(max_value, new_health)
	
	if value <= 0:
		queue_free()
		
	if value < prev_health:
		print("breadcrum 1")
		timer.start()
	else:
		damage_bar.value = value
		print("breadcrum 2")

func _process(delta: float) -> void:
	value = stats.health
	if value <= 0:
		queue_free()
	
	if value < stats.previous_health:
		timer.start()
		stats.previous_health = value

# Called when the node enters the scene tree for the first time.
func init_health(_stats):
	stats = _stats
	max_value = stats.curr_max_health
	damage_bar.max_value = stats.curr_max_health
	damage_bar.value = damage_bar.max_value
	

func _on_timer_timeout() -> void:
	print("timer ran out")
	damage_bar.value = value
