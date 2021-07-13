extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var test = AudioStreamOGGVorbis.new()
var tast : float = 0.0

export(float) var song_cursor = 0.0
export(bool) var snapping = true
export(float) var BPM = 240
export(String) var song
export(Dictionary) var testionary
# Called when the node enters the scene tree for the first time.
func _ready():
	$"Right Note/AnimationPlayer".play("SPIIIIIN")
	$"Import Button".focus_mode = Control.FOCUS_NONE
	$"Export Button".focus_mode = Control.FOCUS_NONE
	pass
	
#	var test3 = bytes2var(testwav.data[0])
#	print(test3)
	#pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if snapping:
		var step_sec = 60.0/(BPM*4.0*max(1.0,floor($"Song Chart Transform".scale.y)))
		var snapped_song_pos = stepify(song_time_transform(get_global_mouse_position().y), step_sec*1000.0)
		song_cursor = inv_song_time_transform(snapped_song_pos)
#	song_cursor = 512.0
func play_snippet():
	var start_time = song_time_transform(get_global_mouse_position().y)
	
	$"Enemy Voice".stop()
	$"Player Voice".stop()
	$"Instrumentals".stop()
	
	$"Instrumentals".playing_snippet = true
	if get_global_mouse_position().x<0.0:
		$"Enemy Voice".play(start_time/1000.0)
	else:
		$"Player Voice".play(start_time/1000.0)
#	$"Instrumentals".play(start_time/1000.0)
	
	$"Snippet Timer".start()

func _input(event):
	if event is InputEventMouseMotion:
#		print(event.relative)
		if Input.is_key_pressed(KEY_CONTROL):
			play_snippet()
	if event.is_action_pressed("save"):
		export_chart("res://assets/weeks/zappity/zappity/", "testchart")
func play():
	var start_time = max(song_time_transform(0.0),0.0)
	$"Enemy Voice".play(start_time/1000.0)
	$"Player Voice".play(start_time/1000.0)
	$"Instrumentals".play(start_time/1000.0)

func stop():
	$"Enemy Voice".stop()
	$"Player Voice".stop()
	$"Instrumentals".stop()

func song_time_transform(pos):
	return ($"Song Chart Transform/Song Position".global_transform.affine_inverse()*Vector2(0,pos)).y

func inv_song_time_transform(ms_time):
	return ($"Song Chart Transform/Song Position".global_transform*Vector2(0.0,ms_time)).y

func _on_Song_Chart_Transform_zoom_updated():
	$"Arrow Track".scroll_speed = $"Song Chart Transform".scale.y
	$"Arrow Track".song_time = -$"Song Chart Transform/Song Position".position.y
	
	$"Arrow Track2".scroll_speed = $"Song Chart Transform".scale.y
	$"Arrow Track2".song_time = -$"Song Chart Transform/Song Position".position.y


func _on_Snippet_Timer_timeout():
	$"Enemy Voice".stop()
	$"Player Voice".stop()
	$"Instrumentals".stop()
#	$"Enemy Voice".seek(song_time_transform(0.0)/1000.0)
#	$"Player Voice".seek(song_time_transform(0.0)/1000.0)
#	$"Instrumentals".seek(song_time_transform(0.0)/1000.0)
	$"Enemy Voice".stop()
	$"Player Voice".stop()
	$"Instrumentals".stop()
	$"Instrumentals".playing = false
	$"Instrumentals".playing_snippet = false

class Note_sorter:
	static func sort_notes(a,b):
		return a[0]<b[0]

func export_chart(folder, file):
	var player_notes = $"Arrow Track".get_notes()
	var player_note_array = []
	for note in player_notes:
		player_note_array += [[note.hit_time, note.note_type, note.hold_time*float(note.hold_note)]]
	player_note_array.sort_custom(Note_sorter, "sort_notes")
	
	var enemy_notes = $"Arrow Track2".get_notes()
	var enemy_note_array = []
	for note in enemy_notes:
		enemy_note_array += [[note.hit_time, note.note_type, note.hold_time*float(note.hold_note)]]
	enemy_note_array.sort_custom(Note_sorter, "sort_notes")
	var save_data = {}
	save_data["boyfriend_notes"] = player_note_array
	save_data["zappity_notes"] = enemy_note_array
	var c_time = "%s_%s_%s_%s-%s-%s"%[OS.get_datetime()["month"],OS.get_datetime()["day"],OS.get_datetime()["year"],OS.get_datetime()["hour"],OS.get_datetime()["minute"],OS.get_datetime()["second"]]
	print(c_time)
	var save_file = File.new()
	save_file.open("%s%s%s.txt"%[folder,file,c_time], File.WRITE)
	save_file.store_string(JSON.print(save_data))
	save_file.close()


func export_fnf_chart(folder, file):
	var player_notes = $"Arrow Track".get_notes()
	var player_note_array = []
	for note in player_notes:
		player_note_array += [[note.hit_time, note.note_type, note.hold_time]]
	player_note_array.sort_custom(Note_sorter, "sort_notes")
	
	var enemy_notes = $"Arrow Track2".get_notes()
	var enemy_note_array = []
	for note in enemy_notes:
		enemy_note_array += [[note.hit_time, note.note_type, note.hold_time]]
	enemy_note_array.sort_custom(Note_sorter, "sort_notes")
	
	var section_length = 8.0*1000.0*60.0/BPM
	
	var save_data = {}
	var notes = []
	var sec_num = 1
	
	while (player_note_array != []) and (enemy_note_array != []):
		print("\nNEW SECTION\n")
		var note_data = {}
		note_data["mustHitSection"] = false
		note_data["typeOfSection"] = 0
		note_data["lengthinSteps"] = 16
		note_data["bpm"] = BPM
		note_data["changeBPM"] = false
		note_data["sectionNotes"] = []
		var section_note_arr = [[],[]]
		var player_note = player_note_array.pop_front()
		var enemy_note = enemy_note_array.pop_front()
		print("player note", player_note)
		print("enemy note", enemy_note)
		print("section_length*sec_num ", section_length*sec_num)
		if player_note == null:
			while enemy_note[0] < section_length*sec_num:
				note_data["sectionNotes"] += [enemy_note]
				enemy_note = enemy_note_array.pop_front()
				if enemy_note == null:
					break
			if player_note == null: break
			continue
		
		if enemy_note == null:
			note_data["mustHitSection"] = true
			while player_note[0] < section_length*sec_num:
				note_data["sectionNotes"] += [player_note]
				player_note = enemy_note_array.pop_front()
				if player_note == null:
					break
			if player_note == null: break
			continue
		
		if player_note[0] < enemy_note[0]:
			print("THIS IS A mustHitSection LOL ", player_note[0], " ", enemy_note[0])
			note_data["mustHitSection"] = true
		
		while (player_note[0] < section_length*sec_num) or (enemy_note[0] < section_length*sec_num):
			if note_data["mustHitSection"]:
				if player_note[0] <= enemy_note[0]:
					note_data["sectionNotes"] += [player_note]
				if player_note[0] > enemy_note[0]:
					enemy_note[1] += 4
					note_data["sectionNotes"] += [enemy_note]
				player_note = player_note_array.pop_front()
				enemy_note = enemy_note_array.pop_front()
				continue
			
			if player_note[0] <= enemy_note[0]:
				print("yeah the player should have it the thing what?")
				print(player_note)
				print(enemy_note)
				player_note[1] += 4
				note_data["sectionNotes"] += [player_note]
			if player_note[0] > enemy_note[0]:
				note_data["sectionNotes"] += [enemy_note]
			print("okay what is actually happening here?")
			print(player_note)
			print(enemy_note)
			if player_note[0]<section_length*sec_num:
				player_note = player_note_array.pop_front()
			if enemy_note[0]<section_length*sec_num:
				enemy_note = enemy_note_array.pop_front()
#			print(enemy_note)
#			print(enemy_note_array)
#			print("yeah alls' good\n\n")
#			print("okay wait")
#			print(enemy_note)
#			print(enemy_note_array)
#			print(":eyarhsf")
			if (player_note == null) or (enemy_note == null):
				break
		notes += [note_data]
		sec_num += 1
#		while 
#		if player_note_array != []:
#			if player_note_array[0] < section_length*sec_num:
#				section_note_arr[0] += [player_note_array.pop_front()]
#		if enemy_note_array != []:
#			if enemy_note_array[0] < section_length*sec_num:
#				section_note_arr[1] += [enemy_note_array.pop_front()]
#		if section_note_arr[0][0] < section_note_arr[1][0]:
#			note_data["mustHitSection"] = true
	save_data["song"] = {"sectionLengths":[],"player1" : "bf", "notes" : notes,"player2":"whittyCrazy","song":"Ballistic-Old","stage":"ballisticAlley","gfVersion":"whitty","validScore":true,"sections":0,"needsVoices":true,"speed":2.6,"bpm":210}
	var c_time = "%s_%s_%s_%s-%s-%s"%[OS.get_datetime()["month"],OS.get_datetime()["day"],OS.get_datetime()["year"],OS.get_datetime()["hour"],OS.get_datetime()["minute"],OS.get_datetime()["second"]]
	print(c_time)
	var save_file = File.new()
	save_file.open("%s%s%s.json"%[folder,file,c_time], File.WRITE)
	save_file.store_string(JSON.print(save_data))
	save_file.close()

func simple_export_fnf_chart(folder,file):
	var player_notes = $"Arrow Track".get_notes()
	var player_note_array = []
	for note in player_notes:
		player_note_array += [[note.hit_time, note.note_type, note.hold_time]]
	player_note_array.sort_custom(Note_sorter, "sort_notes")
	
	var enemy_notes = $"Arrow Track2".get_notes()
	var enemy_note_array = []
	for note in enemy_notes:
		enemy_note_array += [[note.hit_time, note.note_type, note.hold_time]]
	enemy_note_array.sort_custom(Note_sorter, "sort_notes")
	
	var section_length = 8.0*1000.0*60.0/BPM
	
	var save_data = {}
	var notes = []
	var sec_num = 1
	var ugh = true
	while (player_note_array != []) and (enemy_note_array != []) and ugh:
		print("\nNEW SECTION\n")
		var note_data = {}
		note_data["mustHitSection"] = true
		note_data["typeOfSection"] = 0
		note_data["lengthinSteps"] = 16
		note_data["bpm"] = BPM
		note_data["changeBPM"] = false
		note_data["sectionNotes"] = []
		for player_note in player_note_array:
			note_data["sectionNotes"] += [player_note]
		for enemy_note in enemy_note_array:
			enemy_note[1] += 4
			note_data["sectionNotes"] += [enemy_note]
		notes = [note_data]
		ugh = false
	save_data["song"] = {"sectionLengths":[],"player1" : "bf", "notes" : notes,"player2":"whittyCrazy","song":"Ballistic-Old","stage":"ballisticAlley","gfVersion":"whitty","validScore":true,"sections":0,"needsVoices":true,"speed":2.6,"bpm":210}
	var c_time = "%s_%s_%s_%s-%s-%s"%[OS.get_datetime()["month"],OS.get_datetime()["day"],OS.get_datetime()["year"],OS.get_datetime()["hour"],OS.get_datetime()["minute"],OS.get_datetime()["second"]]
	print(c_time)
	var save_file = File.new()
	save_file.open("%s%s%s.json"%[folder,file,c_time], File.WRITE)
	save_file.store_string(JSON.print(save_data))
	save_file.close()
func import_chart(file_path, player_notes, enemy_notes):
	var file = File.new()
	file.open(file_path, File.READ)
	var content = file.get_as_text()
	file.close()
	var chart_data = JSON.parse(content).result
	print(chart_data)
	for note in chart_data[player_notes]:
		print("UUUUUGH")
		$"Arrow Track".import_note(note)
	
	for note in chart_data[enemy_notes]:
		
		print("AAAAAGHASDFAHS")
		$"Arrow Track2".import_note(note)


func _on_Import_Button_pressed():
	import_chart("res://assets/weeks/zappity/zappity/testchart7_13_2021_2-5-6.txt", "boyfriend_notes", "zappity_notes")


func _on_Export_Button_pressed():
	print("\n\n\nEXPORTING\n\n")
	simple_export_fnf_chart("res://assets/weeks/zappity/zappity/", "fnftestchart_")
