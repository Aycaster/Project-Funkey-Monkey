class_name Attack

var parent : Rob
var move : Movement_Rob
var desc : Descriptor
var anim : RobAnimation
var stats : Stats
var hitbox_shape: Shape2D

const attack_list := [
	{"Name": "Light Punch", "Priority": 1, "Cancellable": true},
	{"Name": "Heavy Punch", "Priority": 1, "Cancellable": false},
	{"Name": "Light Kick", "Priority": 1, "Cancellable": true},
	{"Name": "Heavy Kick", "Priority": 1, "Cancellable": false}
	]

# How fast the attack is
var attack_speed = 1.0 / 7.0

# Used to refernce where ever in the script.
var hit_box = null

# Lists of the attacks that need to go off
var attack_executed : Array[Dictionary] = []


func init(_parent : Rob, _move : Movement_Rob, _desc : Descriptor, _anim : RobAnimation, _hitbox_shape : Shape2D, _stats : Stats) -> void:
	
	parent = _parent
	move = _move
	desc = _desc
	anim = _anim
	hitbox_shape = _hitbox_shape
 
# Handles the basic functions and logging them in a buffer list.
func attack() -> void:
	
	# Adds the attack into the dictionary if its in the attack list.
	for atk in attack_list:
		if Input.is_action_just_pressed(atk["Name"]):
			# This is the information that I need to keep track of when logging the attack.
			attack_executed.push_back({
				"Name": atk["Name"],
				"Phase": "startup",
				"Boundary_1": 0,
				"Boundary_2": 0,
				"Frame_Progress": 0,
				"Anim_Frames": 0,
				"Current_Total_Frames": 0
			})
			
			# Calculates the boundaries for phases in the attack.
			# This might change later depending on how I feel about after its more developed.
			phase_calc()

	# Starts the attack procedure.
	if attack_executed != []:
		desc.current_attack = attack_executed[0]["Name"]
		if anim.animation == attack_executed[0]["Name"]:
			
			# Sets the speed of the frame progression of the attack animation.
			var anim_frames_t = anim.sprite_frames.get_frame_count(anim.animation)
			attack_executed[0]["Frame_Progress"] += attack_speed
			attack_executed[0]["Current_Total_Frames"] += 1
			anim.set_frame_and_progress(attack_executed[0]["Anim_Frames"], attack_executed[0]["Frame_Progress"])
			print("---------")
			print("Current frame count %s" % attack_executed[0]["Current_Total_Frames"])
			print("Current frame progress %s" % attack_executed[0]["Frame_Progress"])
			
			
			# Changes the phase of the attack when the total frame progression is equal or greater than the boundary.
			if attack_executed[0]["Current_Total_Frames"] >= attack_executed[0]["Boundary_1"] and attack_executed[0]["Current_Total_Frames"] <= attack_executed[0]["Boundary_2"]:
				print("active phase")
				attack_executed[0]["Phase"] = "active"
			elif attack_executed[0]["Current_Total_Frames"] >= attack_executed[0]["Boundary_2"]:
				print("recovery phase")
				attack_executed[0]["Phase"] = "recovery"
			else:
				print("startup phase")
				
			if attack_executed[0]["Phase"] == "active":
				if not is_instance_valid(hit_box):
					print_rich("[color=red]Variable made[/color]")
					hit_box = HitBox.new(stats, hitbox_shape)
					parent.add_child(hit_box)
			if attack_executed[0]["Phase"] == "recovery":
				if is_instance_valid(hit_box):
					print_rich("[color=green]Deleted child node successfully![/color]")
					hit_box.queue_free()
			
			# Changes the frames whenever the frame progress reaches 1.
			# Ends the animation if the totals frames is equal to the animation frames - 1
			# and removes the attack from the dictionary.
			if attack_executed[0]["Anim_Frames"] == anim_frames_t - 1:
				if attack_executed[0]["Frame_Progress"] >= 1.0 - 0.0001:
					print("is this going off?")
					attack_executed[0]["Frame_Progress"] = 0
					attack_executed.pop_front()
			elif attack_executed[0]["Frame_Progress"] >= 1.0 - 0.0001:
				attack_executed[0]["Frame_Progress"] = 0
				attack_executed[0]["Anim_Frames"] += 1
				print("Frame number %s" % attack_executed[0]["Anim_Frames"])
			
			print("----------")
			
	# Pretty self explanatory.
	if attack_executed == []:
		desc.current_attack = "None"
		

# Is used to calculate the boundaries for the attacks in the dictionary.
func phase_calc() -> void:
	
	var anim_frames_t = anim.sprite_frames.get_frame_count(attack_executed.back()["Name"])
	print(anim_frames_t)
	var total_frames = anim_frames_t / attack_speed
	attack_executed.back()["Boundary_1"] = total_frames / 3
	attack_executed.back()["Boundary_2"] = total_frames / 3 * 2
