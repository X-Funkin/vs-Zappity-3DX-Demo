extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var test = AudioStreamOGGVorbis.new()
var tast : float = 0.0

export(float) var song_time

export(float) var song_cursor = 0.0
export(bool) var snapping = true
export(float) var BPM = 240
export(float) var snap_offset
export(String) var song
export(Dictionary) var testionary
var editor_chart_data : Dictionary = {}
export(AudioStreamSample) var enemy_vocals setget set_enemy_vocals, get_enemy_vocals
export(AudioStreamSample) var instrumentals setget set_instrumentals, get_instrumentals
export(AudioStreamSample) var player_vocals setget set_player_vocals, get_player_vocals

export(String) var enemy_vocals_dir
export(String) var instrumentals_dir
export(String) var player_vocals_dir

export(String) var chart_dir
export(String) var chart_file

export(float) var selection_start = 0.0 setget set_selection_start
export(float) var selection_end = 0.0 setget set_selection_end


var show_grid = true
var show_grid_playback = true
var autosave = false
var autosave_time = 10
var playback_offset = 0
var export_as_copies = false
var show_waveforms_playback = true

var load_enemy_waveform = true
var load_instrumentals_waveform = true
var load_player_waveform = true

func set_enemy_vocals(n_vocals : AudioStreamSample):
#	load("res://")
	enemy_vocals = n_vocals
	var waveform_obj = $"Song Chart Transform/Song Position/Waveform Z/Waveform Visualizer"
	waveform_obj.wav_file = n_vocals
	
	if waveform_obj.auto_draw:
		waveform_obj.reload_waveforms()
	$"Enemy Voice".stream = n_vocals
	
func get_enemy_vocals():
	return enemy_vocals

func set_player_vocals(n_vocals : AudioStreamSample):
	player_vocals = n_vocals
	var waveform_obj = $"Song Chart Transform/Song Position/Waveform BF/Waveform Visualizer"
	waveform_obj.wav_file = n_vocals
	
	if waveform_obj.auto_draw:
		waveform_obj.reload_waveforms()
	$"Player Voice".stream = n_vocals

func get_player_vocals():
	return player_vocals

func set_instrumentals(n_vocals : AudioStreamSample):
	instrumentals = n_vocals
	var waveform_obj = $"Song Chart Transform/Song Position/Waveform Inst/Waveform Visualizer"
	waveform_obj.wav_file = n_vocals
	
	if waveform_obj.auto_draw:
		waveform_obj.reload_waveforms()
	$"Instrumentals".stream = n_vocals

func get_instrumentals():
	return instrumentals

func set_selection_start(n_start):
	selection_start = n_start
	if not is_inside_tree(): yield(self, "ready")
	update_selection_highlight()

func set_selection_end(n_end):
	selection_end = n_end
	if selection_end < selection_start:
		selection_end = selection_start
		self.selection_start = n_end
	if not is_inside_tree(): yield(self, "ready")
	update_selection_highlight()

func update_selection_highlight():
	$"Song Chart Transform/Song Position/Seleciton Highlight".position.y = selection_start
	$"Song Chart Transform/Song Position/Seleciton Highlight".scale.y = selection_end-selection_start

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Right Note/AnimationPlayer".play("SPIIIIIN")
	$"Import Button".focus_mode = Control.FOCUS_NONE
	$"Export Button".focus_mode = Control.FOCUS_NONE
	$AcceptDialog.popup()
	pass
	
#	var test3 = bytes2var(testwav.data[0])
#	print(test3)
	#pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if snapping:
		var step_sec = 60.0/(BPM*4.0*max(1.0,floor($"Song Chart Transform".scale.y)))
		var snapped_song_pos = stepify(song_time_transform(get_global_mouse_position().y), step_sec*1000.0)+snap_offset
		song_cursor = inv_song_time_transform(snapped_song_pos)
	else: song_cursor = get_global_mouse_position().y
	$"Beat Snap Guides".material.set_shader_param("Trans",$"Song Chart Transform/Song Position".global_transform.affine_inverse())
	$"Beat Snap Guides".material.set_shader_param("BPM",BPM)
	$"Beat Snap Guides".material.set_shader_param("Snap_Offset",snap_offset)
#	song_cursor = 512.0

func copy_notes():
	print("COPYING NOTES")
	var target_track = $"Arrow Track2"
	if get_global_mouse_position().x > 0.0:
		target_track = $"Arrow Track"
	print(target_track.name)
	for node in get_tree().get_nodes_in_group("Clipboard Notes"):
		node.remove_from_group("Clipboard Notes")
#		pass
	for note in target_track.get_notes():
		print("testing note ", note.hit_time)
		if note.hit_time >= selection_start and note.hit_time <= selection_end:
			print("yeah this goes to the group")
			note.add_to_group("Clipboard Notes")

func paste_notes():
	print("PASTING NOTES")
	var target_track = $"Arrow Track"
	if get_global_mouse_position().x < 0.0:
		target_track = $"Arrow Track2"
	print(target_track.name)
	var clipboard_notes = get_tree().get_nodes_in_group("Clipboard Notes")
	clipboard_notes.sort_custom(Note.NoteSorter, "sort_hit_time")
	var first_hit_time = clipboard_notes[0].hit_time
	for note in clipboard_notes:
		var hit_time = note.hit_time
		note.hit_time = (hit_time-first_hit_time)+song_time_transform(song_cursor)
		target_track.add_editor_note(note)
		note.hit_time = hit_time

func delete_notes():
	var target_track = $"Arrow Track2"
	if get_global_mouse_position().x > 0.0:
		target_track = $"Arrow Track"
	for note in target_track.get_notes():
		print("testing note ", note.hit_time)
		if note.hit_time >= selection_start and note.hit_time <= selection_end:
			note.queue_free()

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

func select_all():
	self.selection_start = 0.0
	self.selection_end = 299792458.0

func _input(event):
	if event is InputEventMouseMotion:
#		print(event.relative)
		if Input.is_key_pressed(KEY_CONTROL):
			play_snippet()
	if event.is_action_pressed("save"):
		simple_export_fnf_chart("res://assets/weeks/zappity/zappity/", "testchart")
#		export_chart("res://assets/weeks/zappity/zappity/", "testchart")
		
	if event.is_action_pressed("play_audio"):
		if !$"Instrumentals".playing:
			play()
		else:
			stop()
	if event.is_action_pressed("copy"):
		copy_notes()
	if event.is_action_pressed("paste"):
		paste_notes()
	if event.is_action_pressed("delete"):
		delete_notes()
	if event.is_action_pressed("select_all"):
		select_all()

func _notification(what):
	match what:
		NOTIFICATION_CRASH:
			simple_export_fnf_chart("res://assets/weeks/zappity/zappity/", "testchart")
func play():
	var start_time = max(song_time_transform(0.0),0.0)
	$"Enemy Voice".play(start_time/1000.0)
	$"Player Voice".play(start_time/1000.0)
	$"Instrumentals".play(start_time/1000.0)
	$"Beat Snap Guides".material.set_shader_param("Show_Grid",float(show_grid_playback and show_grid))
	$"Song Chart Transform/Song Position".modulate.a = float(show_waveforms_playback)
func stop():
	$"Enemy Voice".stop()
	$"Player Voice".stop()
	$"Instrumentals".stop()
	$"Beat Snap Guides".material.set_shader_param("Show_Grid",float(show_grid))
	$"Song Chart Transform/Song Position".modulate.a = 1.0

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
		player_note_array += [[note.hit_time, note.note_type, note.hold_time*float(note.hold_note)]]
	player_note_array.sort_custom(Note_sorter, "sort_notes")
	
	var enemy_notes = $"Arrow Track2".get_notes()
	var enemy_note_array = []
	for note in enemy_notes:
		enemy_note_array += [[note.hit_time, note.note_type, note.hold_time*float(note.hold_note)]]
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

func simple_export_fnf_chart(folder,file, as_copy = export_as_copies):
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
#	save_data["song"] = {"sectionLengths":[],"player1" : "bf", "notes" : notes,"player2":"whittyCrazy","song":"Ballistic-Old","stage":"ballisticAlley","gfVersion":"whitty","validScore":true,"sections":0,"needsVoices":true,"speed":2.6,"bpm":210}
	editor_chart_data["song"]["notes"] = notes
	var c_time = "%s_%s_%s_%s-%s-%s"%[OS.get_datetime()["month"],OS.get_datetime()["day"],OS.get_datetime()["year"],OS.get_datetime()["hour"],OS.get_datetime()["minute"],OS.get_datetime()["second"]]
	print(c_time)
	var save_file = File.new()
	if as_copy:
		save_file.open("%s_%s.json"%[chart_file,c_time], File.WRITE)
		save_file.store_string(JSON.print(editor_chart_data))
		save_file.close()
		return 0
	
	save_file.open(chart_file, File.WRITE)
#	save_file.open("%s%s%s.json"%[folder,file,c_time], File.WRITE)
	save_file.store_string(JSON.print(editor_chart_data))
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

func import_fnf_chart(file_path):
	var file = File.new()
	file.open(file_path, File.READ)
	var content = file.get_as_text()
	file.close()
	var file_chart_data = JSON.parse(content).result
	editor_chart_data = file_chart_data
	for note_section in file_chart_data["song"]["notes"]:
		if "bpm" in note_section:
			BPM = note_section["bpm"]
			$"BPM/BPM".text = str(BPM)
		if note_section["mustHitSection"]:
			for note in note_section["sectionNotes"]:
				if note[1] > 3:
					$"Arrow Track2".import_note(note)
					continue
				$"Arrow Track".import_note(note)
			continue
		for note in note_section["sectionNotes"]:
			if note[1] > 3:
				$"Arrow Track".import_note(note)
				continue
			$"Arrow Track2".import_note(note)
	

func _on_Import_Button_pressed():
	$"Chart Import Dialouge".window_title = "Open A Chart File"
	$"Chart Import Dialouge".popup()
#	import_chart("res://assets/weeks/zappity/zappity/testchart7_13_2021_2-5-6.txt", "boyfriend_notes", "zappity_notes")


func _on_Export_Button_pressed():
	print("\n\n\nEXPORTING\n\n")
	simple_export_fnf_chart("res://assets/weeks/zappity/zappity/", "fnftestchart_")


func _on_Load_Enemy_Vocals_pressed():
	if enemy_vocals_dir == "":
		if OS.has_feature("editor"):
			# Running from an editor binary.
			# `path` will contain the absolute path to `hello.txt` located in the project root.
			enemy_vocals_dir = ProjectSettings.globalize_path("res://")
		else:
			enemy_vocals_dir = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	$"Enemy Vocals File Dialog".current_dir = enemy_vocals_dir
	$"Enemy Vocals File Dialog".popup()


func _on_Enemy_Vocals_File_Dialog_file_selected(path):
	var n_vocals = load(path)
	set_enemy_vocals(n_vocals)


func _on_Chart_Import_Dialouge_file_selected(path):
	chart_file = path
	$"Arrow Track".clear_notes()
	$"Arrow Track2".clear_notes()
	import_fnf_chart(path)


func _on_Instrumentals_File_Dialog_file_selected(path):
	var n_vocals = load(path)
	set_instrumentals(n_vocals)


func _on_Player_Vocals_File_Dialog_file_selected(path):
	var n_vocals = load(path)
	set_player_vocals(n_vocals)

func _on_Load_Instrumentals_pressed():
	$"Instrumentals File Dialog".popup()


func _on_Load_Player_Vocals_pressed():
	$"Player Vocals File Dialog".popup()


func _on_LineEdit_text_entered(new_text):
	BPM = float(new_text)
	$"BPM/Snap Offset".release_focus()
	$BPM/BPM.release_focus()


func _on_Snap_Offset_text_entered(new_text):
	snap_offset = float(new_text)
	$"BPM/Snap Offset".release_focus()
	$BPM/BPM.release_focus()



func _on_CheckBox_toggled(button_pressed):
	snapping = button_pressed
	

func recieve_songtime(s_time):
	song_time = s_time
	$"Arrow Track".song_time = s_time
	$"Arrow Track2".song_time = s_time


func _on_Show_Enemy_Waveform_toggled(button_pressed):
	$"Song Chart Transform/Song Position/Waveform Z".modulate.a = float(button_pressed)


func _on_Show_Instrumentals_Waveform_toggled(button_pressed):
	$"Song Chart Transform/Song Position/Waveform Inst".modulate.a = float(button_pressed)


func _on_Show_Player_Waveform_toggled(button_pressed):
	$"Song Chart Transform/Song Position/Waveform BF".modulate.a = float(button_pressed)



func _on_Options_Button_pressed():
#	$"PopupMenu".popup()
	$"Settings Popup".popup()


func _on_SnappingPlayback_toggled(button_pressed):
	show_grid_playback = button_pressed
	if $"Instrumentals".playing:
		$"Beat Snap Guides".material.set_shader_param("Show_Grid",float(button_pressed))


func _on_AlwaysCopy_toggled(button_pressed):
	export_as_copies = button_pressed


func _on_AutoSave_toggled(button_pressed):
	autosave = button_pressed
	$"Settings Popup/VBoxContainer/AutoSaveTime".modulate.a = 0.5*float(button_pressed)+0.5
	$AutoSaveTimer.wait_time = 60.0*autosave_time
	if button_pressed:
		$AutoSaveTimer.start()


func _on_AutoSaveLineEdit_text_entered(new_text):
	autosave_time = float(new_text)
	$AutoSaveTimer.wait_time = min(60.0*autosave_time,5.0)


func _on_PlaybackOffsetLineEdit_text_entered(new_text):
	playback_offset = float(new_text)
	$Instrumentals.offset = playback_offset

func _on_GridLineEdit_text_entered(new_text):
	$"Beat Snap Guides".material.set_shader_param("Primary_Width",float(new_text))


func _on_SubgridLineEdit_text_entered(new_text):
	$"Beat Snap Guides".material.set_shader_param("Secondary_Width",float(new_text))


func _on_BGColorPicker_color_changed(color):
	$"Beat Snap Guides".material.set_shader_param("Background_Color",color)


func _on_GridPrimaryColorPicker_color_changed(color):
	$"Beat Snap Guides".material.set_shader_param("Primary_LInes",color)


func _on_GridSecondaryColorPicker_color_changed(color):
	$"Beat Snap Guides".material.set_shader_param("Secondary_Lines",color)


func _on_EnemyVocalsColorPicker_color_changed(color):
	$"Song Chart Transform/Song Position/Waveform Z/Waveform Visualizer".modulate = color


func _on_InstrumentalsColorPicker_color_changed(color):
	$"Song Chart Transform/Song Position/Waveform Inst/Waveform Visualizer".modulate = color


func _on_PlayerVocalsColorPicker_color_changed(color):
	$"Song Chart Transform/Song Position/Waveform BF/Waveform Visualizer".modulate = color


func _on_CheckBox2_toggled(button_pressed):
	show_grid = button_pressed
	$"Beat Snap Guides".material.set_shader_param("Show_Grid",float(button_pressed))


func _on_Load_Enemy_Waveform_toggled(button_pressed):
	$"Song Chart Transform/Song Position/Waveform Z/Waveform Visualizer".auto_draw = button_pressed
	$"Song Chart Transform/Song Position/Waveform Z/Waveform Visualizer".visible = button_pressed
	load_enemy_waveform = button_pressed

func _on_Load_Instrumentals_Waveform_toggled(button_pressed):
	$"Song Chart Transform/Song Position/Waveform Inst/Waveform Visualizer".auto_draw = button_pressed
	$"Song Chart Transform/Song Position/Waveform Inst/Waveform Visualizer".visible = button_pressed
	load_instrumentals_waveform = button_pressed


func _on_Load_Player_Waveform_toggled(button_pressed):
	$"Song Chart Transform/Song Position/Waveform BF/Waveform Visualizer".auto_draw = button_pressed
	$"Song Chart Transform/Song Position/Waveform BF/Waveform Visualizer".visible = button_pressed
	load_player_waveform = button_pressed


func _on_WaveformPlayback_toggled(button_pressed):
	show_waveforms_playback = button_pressed
	if $"Instrumentals".playing:
		$"Song Chart Transform/Song Position".modulate.a = float(button_pressed)


func _on_Arrow_Track_added_editor_note():
	$"Song Chart Transform".emit_signal("zoom_updated")
#	$"Arrow Track".scroll_speed = $"Song Chart Transform".scale.y
#	$"Arrow Track".song_time = -$"Song Chart Transform/Song Position".position.y
#
#	$"Arrow Track2".scroll_speed = $"Song Chart Transform".scale.y
#	$"Arrow Track2".song_time = -$"Song Chart Transform/Song Position".position.y




func _on_Left_Arrow_Edit_added_hold():
	$"Song Chart Transform".emit_signal("zoom_updated")


func _on_Down_Arrow_Edit_added_hold():
	$"Song Chart Transform".emit_signal("zoom_updated")


func _on_Up_Arrow_Edit_added_hold():
	$"Song Chart Transform".emit_signal("zoom_updated")


func _on_Right_Arrow_Edit_added_hold():
	$"Song Chart Transform".emit_signal("zoom_updated")


func _on_Player_Vocals_Volume_value_changed(value):
	$"Player Voice".volume_db = linear2db(value/100.0)
	$"Song Chart Transform/Song Position/Waveform BF/Waveform Visualizer".scale.x = value/100.0
	pass # Replace with function body.


func _on_Instrumentals_Volume_value_changed(value):
	$"Instrumentals".volume_db = linear2db(value/100.0)
	$"Song Chart Transform/Song Position/Waveform Inst/Waveform Visualizer".scale.x = value/100.0
	pass # Replace with function body.


func _on_Enemy_Vocals_Volume_value_changed(value):
	$"Enemy Voice".volume_db = linear2db(value/100.0)
	$"Song Chart Transform/Song Position/Waveform Z/Waveform Visualizer".scale.x = value/100.0
	pass # Replace with function body.


func _on_Center_Track_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_RIGHT:
			if Input.is_key_pressed(KEY_SHIFT):
				self.selection_end = song_time_transform(song_cursor)
				return 0
			self.selection_start = song_time_transform(song_cursor)
			self.selection_end = selection_start
			pass
		pass
	pass # Replace with function body.


func _on_Exit_Button_pressed():
	get_tree().change_scene("res://assets/scenes/Menu Screens.tscn")
	pass # Replace with function body.


func _on_Help_Button_pressed():
	$HelpDialog.popup()
	pass # Replace with function body.


func _on_AutoSaveTimer_timeout():
	simple_export_fnf_chart("res://assets/weeks/zappity/zappity/", "fnftestchart_", true)
	pass # Replace with function body.


func _on_ControlsButton_pressed():
	$ControlsDialog.popup()
	pass # Replace with function body.


func _on_TechnicalHoopsButton_pressed():
	$TechnicalHoopsDialog.popup()
	pass # Replace with function body.


func _on_AcceptDialog_popup_hide():
	$"Chart Import Dialouge".window_title = "Open A Chart File To Begin"
	$"Chart Import Dialouge".popup()
	get_tree().paused = true
	pass # Replace with function body.


func _on_Chart_Import_Dialouge_popup_hide():
	get_tree().paused = false
	pass # Replace with function body.
