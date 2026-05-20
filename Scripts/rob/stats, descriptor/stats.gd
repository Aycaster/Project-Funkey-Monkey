extends Node
class_name Stats

enum Type {
	Player,
	Enemy,
}

signal health_depleted
signal health_shift(cur_health : int, max_health : int)

const Base_Level_XP := 100.0

# These stats below are the starting level stats for the character.
@export var base_max_health := 100
@export var base_max_stamina := 100
@export var base_max_attack := 10
@export var base_max_defense := 10
@export var base_max_weight := 10
@export var type := Type.Player
@export var experience := 0 : set = exp_change

# This is where the current stats will reside.
var level : int: 
	get(): return floor(max(1.0, sqrt(experience / Base_Level_XP) + 0.5))
var current_max_health := 100
var current_stamina := 100
var current_attack := 10
var current_defense := 10
var current_weight := 10

# Current health using the health change function as a setter.
var current_health := 0 : set = health_change

func _init() -> void:
	stat_setup()

func stat_setup() -> void:
	current_max_health = base_max_health
	current_stamina = base_max_stamina
	current_attack = base_max_attack
	current_defense = base_max_defense
	current_weight = base_max_weight

func damage_take(amount: int) -> void:
	current_health -= amount

func health_change(new_value : int) -> void:
	current_health = clampi(new_value, 0, base_max_health)
	health_shift.emit(current_health, base_max_health)
	if current_health <= 0:
		health_depleted.emit()

func exp_change(new_value : int) -> void:
	pass
