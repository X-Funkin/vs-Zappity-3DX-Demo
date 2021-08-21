extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var data = {"settings":{},"default_settings":{},
"controls":{"note_left":[68],"note_down":[70],"note_up":[74],"note_right":[75]}, "volume":100}
#var settings = {}
#var default_settings = {}

#var volume = 100.0 setget set_volume

var game_data_file = "user://../XDX Engine/Game_Data.json"

func load_game_data():
	var file = File.new()
	file.open(game_data_file, File.READ)
	var new_data = JSON.parse(file.get_as_text()).result
	if not data is Dictionary:
		data = {"settings":{},"default_settings":{}}
	if new_data is Dictionary:
		for thing in new_data:
			data[thing] = new_data[thing]
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

func screenshot():
	var image = get_viewport().get_texture().get_data()
	var c_time = "%s-%s-%s-%s_%s_%s"%[OS.get_datetime()["month"],OS.get_datetime()["day"],OS.get_datetime()["year"],OS.get_datetime()["hour"],OS.get_datetime()["minute"],OS.get_datetime()["second"]]
	print(c_time)
	image.flip_y()
	image.save_png("res://screenshots/screenshot_%s.png"%c_time)

func change_volume(volume):
	var volume_node = get_node_or_null("Volume UI/Volume UI")
	if not volume_node:
		var volume_ui = load("res://assets/scenes/Volume UI.tscn").instance()
		var canvas = CanvasLayer.new()
		canvas.name = "Volume UI"
		canvas.add_child(volume_ui)
		add_child(canvas)
		volume_node = volume_ui
	volume_node.change_volume(volume)
	pass

#func set_volume(n_volume):
#	data.volume = volume
#	load_volume()

func load_volume():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), data.volume/100.0)

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_F12 and event.pressed and !event.is_echo():
			screenshot()
		if event.scancode == KEY_EQUAL and event.pressed:
			data.volume = clamp(data.volume+10.0, 0, 100)
			change_volume(data.volume)
		if event.scancode == KEY_MINUS and event.pressed:
			data.volume = clamp(data.volume-10.0, 0, 100)
			change_volume(data.volume)

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game_data()
	load_controls()
#	load_volume()
#	self.volume = data.volume
	pass # Replace with function body.

func _notification(what):
	match what:
		NOTIFICATION_EXIT_TREE:
			save_game_data()
#		NOTIFICATION_READY:
#			load_volume()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
