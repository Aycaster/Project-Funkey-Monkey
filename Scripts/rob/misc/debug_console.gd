extends Node

var looking := {}

@onready var label: Label = null

func _ready():
	label = Label.new()
	label.name = "debug_label"
	label.set_position(Vector2(10, 10))
	label.set("theme_override_colors/font_color", Color(1, 1, 1))
	get_tree().root.add_child.call_deferred(label)

func look(subject: String, value) -> void:
	looking[subject] = value
	
func look_away(subject: String) -> void:
	looking.erase(subject)
	
func clear() -> void:
	looking.clear()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if label == null:
		return
	var text := ""
	for i in looking.keys():
		text += "%s: %s\n" % [i, str(looking[i])]
	label.text = text
