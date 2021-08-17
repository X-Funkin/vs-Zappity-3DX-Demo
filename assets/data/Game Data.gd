extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var data = {"settings":{},"default_settings":{},
"controls":{"note_left":[68],"note_down":[70],"note_up":[74],"note_right":[75]}}
#var settings = {}
#var default_settings = {}

var game_data_file = "user://../XDX Engine/Game_Data.json"

func load_game_data():
	var file = File.new()
	file.open(game_data_file, File.READ)
	data = JSON.parse(file.get_as_text()).result
	if not data is Dictionary:
		data = {"settings":{},"default_settings":{}}
	pass

func save_game_data():
	var file = File.new()
	file.open(game_data_file, File.WRITE)
	file.store_string(JSON.print(data))
	file.close()

func load_controls():
	for control in data.controls:
		print(control)
		var input_events = InputMap.get_action_list(control)
		for event in input_events:
			InputMap.action_erase_event(control,event)
		for scancode in data.controls[control]:
			var new_event = InputEventKey.new()
			new_event.scancode = scancode
			InputMap.action_add_event(control,new_event)
		
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game_data()
	load_controls()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
