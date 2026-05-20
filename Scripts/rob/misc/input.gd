class_name Input_Rob

const inputs := ["Move Left", "Move Right", "Move Up", "Move Down", "Secondary Input", "Light Punch", "Light Kick", "Heavy Punch", "Heavy Kick"]

const default_layout := {
	"Move Left": KEY_A, 
	"Move Right": KEY_D, 
	"Move Up": KEY_W, 
	"Move Down": KEY_S,  
	"Secondary Input": KEY_F,
	"Light Punch": KEY_I,
	"Light Kick": KEY_O,
	"Heavy Punch": KEY_K,
	"Heavy Kick": KEY_L}

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	for input in inputs:
		
		if not InputMap.has_action(input):
			InputMap.add_action(input)
		
		if InputMap.has_action(input):
			var event := InputEventKey.new()
			if input in default_layout.keys():
				event.physical_keycode = default_layout[input]
				if not InputMap.action_has_event(input, event):
					
					InputMap.action_add_event(input, event)
			else:
				print("This does not exist in the current layout.")
