extends Resource
class_name Stats

enum BuffableStats {
	MAX_HEALTH,
	DEFENSE,
	ATTACK,
}

const STAT_CURVES: Dictionary[BuffableStats, Curve] = {
	BuffableStats.MAX_HEALTH: preload("uid://cykt0qhs0rp6l"),
	BuffableStats.DEFENSE: preload("uid://ep3fxl1ai5mw"),
	BuffableStats.ATTACK: preload("uid://c0dakcdtacte"),
}

const BASE_LEVEL_XP: float = 100.0

signal health_depleted
signal health_changed(cur_health: int, max_health: int)

@export var base_max_health: int = 100
@export var base_defense: int = 10
@export var base_attack: int = 10
@export var experience: int = 0: set = _on_experience_set

var level: int:
	get(): return floor(max(1.0, sqrt(experience/ BASE_LEVEL_XP) + 0.5))
var curr_max_health: int = 100
var curr_defense: int = 10
var curr_attack: int = 10

@export var health: int =0: set = _on_health_set

var stat_buffs: Array[StatBuff]

func _init() -> void:
	setup_stats.call_deferred()
	
func setup_stats() -> void:
	# recalculate the current stats first
	recalculate_stats()
	health = curr_max_health
	
func add_buff(buff: StatBuff) -> void:
	stat_buffs.append(buff)
	recalculate_stats.call_deferred()
	
func remove_buff(buff: StatBuff) -> void:
	stat_buffs.erase(buff)
	recalculate_stats.call_deferred()
	
func recalculate_stats() -> void:
	var stat_multipliers: Dictionary = {} # Amount to multiply included stats by
	var stat_addends: Dictionary = {} # Amount to add to included stats
	for buff in stat_buffs:
		var stat_name: String = BuffableStats.keys()[buff.stat].to_lower()
		match buff.buff_type:
			StatBuff.BuffType.ADD:
				if not stat_addends.has(stat_name):
					stat_addends[stat_name] = 0.0
				stat_addends[stat_name] += buff.buff_amount
				
			StatBuff.BuffType.MULTIPLY:
				if not stat_multipliers.has(stat_name):
					stat_multipliers[stat_name] = 1.0
				stat_multipliers[stat_name] += buff.buff_amount
				
				if stat_multipliers[stat_name] < 0.0:
					stat_multipliers[stat_name] = 0.0
	
	
	var stat_sample_pos: float = (float(level) / 100.0) - 0.01
	curr_max_health = base_max_health * STAT_CURVES[BuffableStats.MAX_HEALTH].sample(stat_sample_pos)
	curr_defense = base_defense * STAT_CURVES[BuffableStats.DEFENSE].sample(stat_sample_pos)
	curr_attack = base_attack * STAT_CURVES[BuffableStats.ATTACK].sample(stat_sample_pos)
	
	for stat_name in stat_multipliers:
		var curr_property_name: String = str("curr_" + stat_name)
		set(curr_property_name, get(curr_property_name) * stat_multipliers[stat_name])
		
	for stat_name in stat_addends:
		var curr_property_name: String = str("curr_" + stat_name)
		set(curr_property_name, get(curr_property_name) + stat_addends[stat_name])
	
func _on_health_set(new_value: int) -> void:
	health = clampi(new_value, 0, curr_max_health)
	health_changed.emit(health, curr_max_health)
	if health <= 0:
		health_depleted.emit()

func _on_experience_set(new_value: int) -> void:
	var old_level: int = level
	experience = new_value 
	
	if not old_level == level:
		recalculate_stats()
