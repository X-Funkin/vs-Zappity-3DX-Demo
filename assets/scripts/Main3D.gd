extends Spatial

export(String) var song_name
export(Texture) var freeplay_icon
export(String, FILE) var easy_chart
export(String, FILE) var normal_chart
export(String, FILE) var hard_chart
export(float) var bpm = 120.0
export(NodePath) var player_track
export(NodePath) var enemy_track
export(float, EXP, -80.0,10.0) var player_volume_db = 0.0
export(float, EXP, -80.0,10.0) var instrumentals_volume_db = 0.0
export(float, EXP, -80.0,10.0) var enemy_volume_db = 0.0
export(NodePath) var player_vocals
export(NodePath) var instrumentals
export(NodePath) var enemy_vocals
export(NodePath) var sounds_path
export(NodePath) var label_thingy
export(NodePath) var label_thingy_2
export(PackedScene) var target_scene
export(String, FILE) var song_data_file
var chart_file = ""
var player_combo = 0


func set_player_volume_db(n_volume):
	player_volume_db = n_volume
	if not is_inside_tree(): yield(self, "ready")
	get_node(player_vocals).volume_db = n_volume

func set_instrumentals_volume_db(n_volume):
	instrumentals_volume_db = n_volume
	if not is_inside_tree(): yield(self, "ready")
	get_node(instrumentals).volume_db = n_volume

func set_enemy_volume_db(n_volume):
	enemy_volume_db = n_volume
	if not is_inside_tree(): yield(self, "ready")
	get_node(enemy_vocals).volume_db = n_volume

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group("Note Track", "load_chart")
	$"Audio Tracks".start()
	self.player_volume_db = player_volume_db
	self.instrumentals_volume_db = instrumentals_volume_db
	self.enemy_volume_db = enemy_volume_db
	pass # Replace with function body.


func score_note(scoring_group):
	print("scoring notes")
#	print("funcing callced")
	var song_time = get_node(instrumentals).get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
	song_time *= 1000.0
	song_time += $"Audio Tracks".offset_ms
	var scorable_notes = get_tree().get_nodes_in_group(scoring_group)
	print(scorable_notes)
#	print("scorable notes ", scorable_notes)
	if scorable_notes != []:
		var closest_note : Note = scorable_notes[0]
		var hit_error = closest_note.hit_time-song_time
		for note in scorable_notes:
#			print("scorable note ", note)
			if abs(note.hit_time-song_time) < abs(hit_error):
				closest_note = note
				hit_error = closest_note.hit_time-song_time
		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, hit_error)
		judge_hit(hit_error)
		player_combo += 1
		get_tree().call_group("Player Hit Recievers", "recieve_player_combo", player_combo)
#		get_node(label_thingy).text = "%5.4f ms"%hit_error
		if closest_note.hold_note:
			closest_note.holding = true
			closest_note.playing = true
			closest_note.score_note()
		else: closest_note.despawn()

func judge_hit(hit_error):
	var judgement = 1
	if abs(hit_error) <= 127.5:
		judgement = 1
	if abs(hit_error) <= 103.5:
		judgement = 2
	if abs(hit_error) <= 73.5:
		judgement = 3
	if abs(hit_error) <= 40.5:
		judgement = 4
	if abs(hit_error) <= 16.5:
		judgement = 5
	get_tree().call_group("Player Hit Recievers", "recieve_player_judgment", judgement)


#
#func score_left_notes():
#	var scoring_notes = get_tree().get_nodes_in_group("Left Scorable Notes")
#	if scoring_notes != []:
#		var ref_time = $"Audio Tracks/Instrumentals".get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
#		var min_time = abs(scoring_notes[0].hit_time-ref_time*1000.0)
#		var closest_note = scoring_notes[0]
#		for note in scoring_notes:
#			if abs(note.hit_time-ref_time*1000.0) < abs(closest_note.hit_time-ref_time*1000.0):
#				closest_note = note
#		min_time = closest_note.hit_time-ref_time*1000.0
#		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, min_time)
#		return 0
#
#func score_down_notes():
#	var scoring_notes = get_tree().get_nodes_in_group("Down Scorable Notes")
#	if scoring_notes != []:
#		var ref_time = $"Audio Tracks/Instrumentals".get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
#		var min_time = abs(scoring_notes[0].hit_time-ref_time*1000.0)
#		var closest_note = scoring_notes[0]
#		for note in scoring_notes:
#			if abs(note.hit_time-ref_time*1000.0) < abs(closest_note.hit_time-ref_time*1000.0):
#				closest_note = note
#		min_time = closest_note.hit_time-ref_time*1000.0
#		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, min_time)
#		return 0
#
#func score_up_notes():
#	var scoring_notes = get_tree().get_nodes_in_group("Up Scorable Notes")
#	if scoring_notes != []:
#		var ref_time = $"Audio Tracks/Instrumentals".get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
#		var min_time = abs(scoring_notes[0].hit_time-ref_time*1000.0)
#		var closest_note = scoring_notes[0]
#		for note in scoring_notes:
#			if abs(note.hit_time-ref_time*1000.0) < abs(closest_note.hit_time-ref_time*1000.0):
#				closest_note = note
#		min_time = closest_note.hit_time-ref_time*1000.0
#		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, min_time)
#		return 0
#
#func score_right_notes():
#	var scoring_notes = get_tree().get_nodes_in_group("Right Scorable Notes")
#	if scoring_notes != []:
#		var ref_time = $"Audio Tracks/Instrumentals".get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
#		var min_time = abs(scoring_notes[0].hit_time-ref_time*1000.0)
#		var closest_note = scoring_notes[0]
#		for note in scoring_notes:
#			if abs(note.hit_time-ref_time*1000.0) < abs(closest_note.hit_time-ref_time*1000.0):
#				closest_note = note
#		min_time = closest_note.hit_time-ref_time*1000.0
#		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, min_time)
#		return 0


func pause():
	var pause_screen = load("res://assets/scenes/Pause Menu.tscn").instance()
	var canvas = CanvasLayer.new()
	canvas.add_child(pause_screen)
	add_child(canvas)
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !get_tree().paused:
			pause()
	_player_input(event)
	get_tree().call_group("Input Recievers", "recieve_input")
	if event.is_action("note_left"):
		get_tree().call_group("Input Recievers", "recieve_left_input", event)
		return 0
	if event.is_action("note_down"):
		get_tree().call_group("Input Recievers", "recieve_down_input", event)
		return 0
	if event.is_action("note_up"):
		get_tree().call_group("Input Recievers", "recieve_up_input", event)
		return 0
	if event.is_action("note_right"):
		get_tree().call_group("Input Recievers", "recieve_right_input", event)
		return 0
	

func _player_input(event : InputEvent):
#	print("player input", event.name)
	get_tree().call_group("Player Input Recievers", "recieve_player_input", event)
	if !event.is_echo():
		if event.is_action("note_left"):
	#		print("note left")
			get_tree().call_group("Player Input Recievers", "recieve_player_left_input", event)
			return 0
		if event.is_action("note_down"):
			get_tree().call_group("Player Input Recievers", "recieve_player_down_input", event)
			return 0
		if event.is_action("note_up"):
			get_tree().call_group("Player Input Recievers", "recieve_player_up_input", event)
			return 0
		if event.is_action("note_right"):
			get_tree().call_group("Player Input Recievers", "recieve_player_right_input", event)
			return 0



func _enemy_input(event : InputEvent):
	get_tree().call_group("Enemy Input Recievers", "recieve_enemy_input")
	if event.is_action("note_left"):
		get_tree().call_group("Enemy Input Recievers", "recieve_enemy_left_input", event)
		return 0
	if event.is_action("note_down"):
		get_tree().call_group("Enemy Input Recievers", "recieve_enemy_down_input", event)
		return 0
	if event.is_action("note_up"):
		get_tree().call_group("Enemy Input Recievers", "recieve_enemy_up_input", event)
		return 0
	if event.is_action("note_right"):
		get_tree().call_group("Enemy Input Recievers", "recieve_enemy_right_input", event)
		return 0
	

func recieve_player_left_input(event : InputEvent):
	if event.is_pressed():
#		print("supposidly coring")
		score_note("Scorable Left Notes")

func recieve_player_down_input(event : InputEvent):
	if event.is_pressed():
#		print("supposidly coring")
		score_note("Scorable Down Notes")

func recieve_player_up_input(event : InputEvent):
	if event.is_pressed():
#		print("supposidly coring")
		score_note("Scorable Up Notes")

func recieve_player_right_input(event : InputEvent):
	if event.is_pressed():
#		print("supposidly coring")
		score_note("Scorable Right Notes")

func change_floor_first_color(note_type):
	var col = Color(0,0,1)
	match note_type:
		0:
			col = Color(1,0,1)
		1:
			col = Color(0,1,1)
		2:
			col = Color(0,1,0)
		3:
			col = Color(1,0,0)
	$"cube room/Cube".get_surface_material(1).set_shader_param("First_Glow_Color", col)
	col.s *= 0.5
	$"cube room/Cube".get_surface_material(1).set_shader_param("First_Line_Color", col)

func change_floor_second_color(note_type):
	var col = Color(0,0,1)
	match note_type:
		0:
			col = Color(1,0,1)
		1:
			col = Color(0,1,1)
		2:
			col = Color(0,1,0)
		3:
			col = Color(1,0,0)
	$"cube room/Cube".get_surface_material(1).set_shader_param("Second_Glow_Color", col)
	col.s *= 0.5
	$"cube room/Cube".get_surface_material(1).set_shader_param("Second_Line_Color", col)


func recieve_player_hit(note : Note, hit_error):
	get_node(player_vocals).volume_db = player_volume_db
	if GameData.data.photosensitivity == 0:
		change_floor_second_color(note.note_type)

func recieve_player_miss(note_type):
	get_node(player_vocals).volume_db = -80.0
	get_node(sounds_path).play_miss()
	player_combo = 0
	get_tree().call_group("Player Hit Recievers", "recieve_player_combo", player_combo)

func recieve_enemy_hit(note : Note, hit_error):
	get_node(enemy_vocals).volume_db = enemy_volume_db
	if GameData.data.photosensitivity == 0:
		change_floor_first_color(note.note_type)

func recieve_player_full_combo(combo):
	$"Boyfriend 3D".play_animation("Peace!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().call_group("Camera Transform Recievers", "recieve_camera_transform", $Camera.global_transform)
	get_tree().call_group("Camera Transform Recievers", "recieve_camera", $Camera)
#	pass
