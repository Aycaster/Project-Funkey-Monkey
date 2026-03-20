extends Node
class_name Attack

var parent : Rob
var move : Movement_Rob
var desc : Descriptor
var anim : RobAnimation

const attack_list := [
	{"Name": "Light Punch", "Priority": 1, "Speed": 400, "Cancellable": true},
	{"Name": "Heavy Punch", "Priority": 1, "Speed": 800, "Cancellable": false},
	{"Name": "Light Kick", "Priority": 1, "Speed": 400, "Cancellable": true},
	{"Name": "Heavy Kick", "Priority": 1, "Speed": 800, "Cancellable": false}
	]

var attack_executed : Array[Dictionary] = []

func _ready() -> void:
	pass

func attack() -> void:
	var current_time = Time.get_ticks_msec()
	
	for atk in attack_list:
		if Input.is_action_just_pressed(atk["Name"]):
			attack_executed.push_front({
				"Name": atk["Name"],
				"Input Time": Time.get_ticks_msec()
			})
	
	if attack_executed != []:
		desc.current_attack = attack_executed[0]["Name"]
		if anim.animation == attack_executed[0]["Name"]:
			
			var anim_frames = anim.sprite_frames.get_frame_count(anim.animation)
			
			if anim.frame == anim_frames - 1:
				if anim.frame_progress >= 0.9:
					attack_executed.pop_front()

	if attack_executed == []:
		desc.current_attack = "None"
