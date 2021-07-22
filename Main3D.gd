extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func score_left_notes():
	var scoring_notes = get_tree().get_nodes_in_group("Left Scorable Notes")
	if scoring_notes != []:
		var ref_time = $"Audio Tracks/Instrumentals".get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
		var min_time = abs(scoring_notes[0].hit_time-ref_time*1000.0)
		var closest_note = scoring_notes[0]
		for note in scoring_notes:
			if abs(note.hit_time-ref_time*1000.0) < abs(closest_note.hit_time-ref_time*1000.0):
				closest_note = note
		min_time = closest_note.hit_time-ref_time*1000.0
		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, min_time)
		return 0

func score_down_notes():
	var scoring_notes = get_tree().get_nodes_in_group("Down Scorable Notes")
	if scoring_notes != []:
		var ref_time = $"Audio Tracks/Instrumentals".get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
		var min_time = abs(scoring_notes[0].hit_time-ref_time*1000.0)
		var closest_note = scoring_notes[0]
		for note in scoring_notes:
			if abs(note.hit_time-ref_time*1000.0) < abs(closest_note.hit_time-ref_time*1000.0):
				closest_note = note
		min_time = closest_note.hit_time-ref_time*1000.0
		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, min_time)
		return 0
		
func score_up_notes():
	var scoring_notes = get_tree().get_nodes_in_group("Up Scorable Notes")
	if scoring_notes != []:
		var ref_time = $"Audio Tracks/Instrumentals".get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
		var min_time = abs(scoring_notes[0].hit_time-ref_time*1000.0)
		var closest_note = scoring_notes[0]
		for note in scoring_notes:
			if abs(note.hit_time-ref_time*1000.0) < abs(closest_note.hit_time-ref_time*1000.0):
				closest_note = note
		min_time = closest_note.hit_time-ref_time*1000.0
		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, min_time)
		return 0
		
func score_right_notes():
	var scoring_notes = get_tree().get_nodes_in_group("Right Scorable Notes")
	if scoring_notes != []:
		var ref_time = $"Audio Tracks/Instrumentals".get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
		var min_time = abs(scoring_notes[0].hit_time-ref_time*1000.0)
		var closest_note = scoring_notes[0]
		for note in scoring_notes:
			if abs(note.hit_time-ref_time*1000.0) < abs(closest_note.hit_time-ref_time*1000.0):
				closest_note = note
		min_time = closest_note.hit_time-ref_time*1000.0
		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", closest_note, min_time)
		return 0


func _input(event):
	get_tree().call_group("Player Input Recievers", "recieve_player_input", event)
	if event.is_action_pressed("ui_accept"):
		print("yea event")
		get_tree().call_group("Enter Recievers", "recieve_enter")
	if event.is_action_pressed("note_left"):
#		get_tree().call_group("Player Input Recievers", "recieve_player_input", event)
		score_left_notes()
		return 0
	if event.is_action_pressed("note_down"):
#		get_tree().call_group("Player Input Recievers", "recieve_player_input", event)
		score_down_notes()
		return 0
	if event.is_action_pressed("note_up"):
#		get_tree().call_group("Player Input Recievers", "recieve_player_input", event)
		score_up_notes()
		return 0
	if event.is_action_pressed("note_right"):
#		get_tree().call_group("Player Input Recievers", "recieve_player_input", event)
		score_right_notes()
		return 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
