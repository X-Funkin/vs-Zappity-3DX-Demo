extends Node2D
class_name Arrow_Track

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var scroll_speed = 1.0 setget set_scroll_speed, get_scroll_speed
export(float) var song_time setget set_song_time, get_song_time
export(String) var chart_file
export(String) var chart_channel
export(bool) var auto_load_chart
export(bool) var player_track
#export(String) var input_receivers_group

var LeftNote : PackedScene = load("res://assets/scenes/Left Note.tscn")
var DownNote : PackedScene = load("res://assets/scenes/Down Note.tscn")
var UpNote : PackedScene = load("res://assets/scenes/Up Note.tscn")
var RightNote : PackedScene = load("res://assets/scenes/Right Note.tscn")
var EditorNote : PackedScene = load("res://assets/scenes/Editor Note.tscn")
onready var DownHold : PackedScene = load("res://assets/scenes/Down Note Hold.tscn")

func set_scroll_speed(n_speed):
	scroll_speed = n_speed
#	for AFOSAHGD in get_children():
#		print(AFOSAHGD.name)
#	print(name)
#	print($"Left Track".name)
#	print($"Left Track/Left Arrow".name)
#	print($"Left Track/Left Arrow/Left Notes Transform".name)
#	print($"Left Track/Left Arrow/Left Notes Transform/Left Notes".name)
#	print($"Left Track/Left Arrow/Left Notes Transform/Left Notes".name)
	$"Left Track/Left Arrow/Left Notes Transform".scale.y = scroll_speed
	$"Down Track/Down Arrow/Down Notes Transform".scale.y = scroll_speed
	$"Up Track/Up Arrow/Up Notes Transform".scale.y = scroll_speed
	$"Right Track/Right Arrow/Right Notes Transform".scale.y = scroll_speed
	
	for node in $"Left Track/Left Arrow/Left Notes Transform/Left Notes".get_children():
		node.scale.y = 1.0/scroll_speed
		node.scale_set(1.0/scroll_speed)
#		node.set_global_scale(1.0/scroll_speed)
	for node in $"Down Track/Down Arrow/Down Notes Transform/Down Notes".get_children():
		node.scale.y = 1.0/scroll_speed
		node.scale_set(1.0/scroll_speed)
#		node.set_global_scale(1.0/scroll_speed)
	for node in $"Up Track/Up Arrow/Up Notes Transform/Up Notes".get_children():
		node.scale.y = 1.0/scroll_speed
		node.scale_set(1.0/scroll_speed)
#		node.set_global_scale(1.0/scroll_speed)
	for node in $"Right Track/Right Arrow/Right Notes Transform/Right Notes".get_children():
		node.scale.y = 1.0/scroll_speed
		node.scale_set(1.0/scroll_speed)
#		node.set_global_scale(1.0/scroll_speed)
func get_scroll_speed():
	return scroll_speed

var OHBOIS = false
func set_song_time(n_time):
	song_time = n_time
#	print("SONG TIME ", song_time)
	$"Left Track/Left Arrow/Left Notes Transform/Left Notes".position.y = -n_time
	$"Down Track/Down Arrow/Down Notes Transform/Down Notes".position.y = -n_time
	$"Up Track/Up Arrow/Up Notes Transform/Up Notes".position.y = -n_time
	$"Right Track/Right Arrow/Right Notes Transform/Right Notes".position.y = -n_time
	if !OHBOIS:
		OHBOIS = true
		print("OH BOIS")
#		get_tree().root.print_tree()
#		get_tree().root.print_tree_pretty()
#		print_tree()
func get_song_time():
	return song_time

func add_note(n_note : Note):
	match n_note.note_type:
		0:
			var l_inst = LeftNote.instance()
			l_inst.hit_time = n_note.hit_time
			l_inst.live = n_note.live
			$"Left Track/Left Arrow/Left Notes Transform/Left Notes".add_child(l_inst)
			l_inst.position.y = n_note.hit_time
			l_inst.global_scale.y = 1.0
			print("yeah added note lol ", l_inst.transform)
			print("lgobal ", l_inst.global_transform)
		1:
			var d_inst = DownNote.instance()
			d_inst.hit_time = n_note.hit_time
			d_inst.live = n_note.live
			print("DOWEAOSDFK")
			$"Down Track/Down Arrow/Down Notes Transform/Down Notes".add_child(d_inst)
			d_inst.position.y = n_note.hit_time
			d_inst.global_scale.y = 1.0
		2:
			var u_inst = UpNote.instance()
			u_inst.hit_time = n_note.hit_time
			u_inst.live = n_note.live
			$"Up Track/Up Arrow/Up Notes Transform/Up Notes".add_child(u_inst)
			u_inst.position.y = n_note.hit_time
			u_inst.global_scale.y = 1.0
		3:
			var r_inst = RightNote.instance()
			r_inst.hit_time = n_note.hit_time
			r_inst.live = n_note.live
			$"Right Track/Right Arrow/Right Notes Transform/Right Notes".add_child(r_inst)
			r_inst.position.y = n_note.hit_time
			r_inst.global_scale.y = 1.0
		
signal added_editor_note

func add_editor_note(n_note : Note):
	var e_inst = EditorNote.instance()
	match n_note.note_type:
		0:
			var l_inst = LeftNote.instance()
			l_inst.add_child(e_inst)
			$"Left Track/Left Arrow/Left Notes Transform/Left Notes".add_child(l_inst)
			l_inst.hit_time = n_note.hit_time
			l_inst.live = n_note.live
			l_inst.hold_time = n_note.hold_time
			l_inst.hold_note = n_note.hold_note
			l_inst.position.y = n_note.hit_time
			l_inst.global_scale.y = 1.0
			print("yeah added note lol ", l_inst.transform)
			print("lgobal ", l_inst.global_transform)
		1:
			var d_inst = DownNote.instance()
			d_inst.add_child(e_inst)
			$"Down Track/Down Arrow/Down Notes Transform/Down Notes".add_child(d_inst)
			d_inst.hit_time = n_note.hit_time
			d_inst.live = n_note.live
			d_inst.hold_time = n_note.hold_time
			d_inst.hold_note = n_note.hold_note
			d_inst.position.y = n_note.hit_time
			d_inst.global_scale.y = 1.0
			
		2:
			var u_inst = UpNote.instance()
			u_inst.add_child(e_inst)
			$"Up Track/Up Arrow/Up Notes Transform/Up Notes".add_child(u_inst)
			u_inst.hit_time = n_note.hit_time
			u_inst.live = n_note.live
			u_inst.hold_time = n_note.hold_time
			u_inst.hold_note = n_note.hold_note
			u_inst.position.y = n_note.hit_time
			u_inst.global_scale.y = 1.0
		3:
			var r_inst = RightNote.instance()
			r_inst.add_child(e_inst)
			$"Right Track/Right Arrow/Right Notes Transform/Right Notes".add_child(r_inst)
			r_inst.hit_time = n_note.hit_time
			r_inst.live = n_note.live
			r_inst.hold_time = n_note.hold_time
			r_inst.hold_note = n_note.hold_note
			r_inst.position.y = n_note.hit_time
			r_inst.global_scale.y = 1.0
#	emit_signal("added_editor_note")



func import_note(n_note):
	var e_inst = EditorNote.instance()
	match int(n_note[1])%4:
		0:
			var l_inst = LeftNote.instance()
			l_inst.add_child(e_inst)
			$"Left Track/Left Arrow/Left Notes Transform/Left Notes".add_child(l_inst)
			l_inst.hit_time = n_note[0]
			l_inst.live = true
			l_inst.hold_time = n_note[2]
			l_inst.hold_note = (n_note[2]>0)
			l_inst.position.y = n_note[0]
			l_inst.global_scale.y = 1.0
			print("yeah added note lol ", l_inst.transform)
			print("lgobal ", l_inst.global_transform)
		1:
			var d_inst = DownNote.instance()
			d_inst.add_child(e_inst)
			$"Down Track/Down Arrow/Down Notes Transform/Down Notes".add_child(d_inst)
			d_inst.hit_time = n_note[0]
			d_inst.live = true
			d_inst.hold_time = n_note[2]
			d_inst.hold_note = (n_note[2]>0)
			d_inst.position.y = n_note[0]
			d_inst.global_scale.y = 1.0
			
		2:
			var u_inst = UpNote.instance()
			u_inst.add_child(e_inst)
			$"Up Track/Up Arrow/Up Notes Transform/Up Notes".add_child(u_inst)
			u_inst.hit_time = n_note[0]
			u_inst.live = true
			u_inst.hold_time = n_note[2]
			u_inst.hold_note = (n_note[2]>0)
			u_inst.position.y = n_note[0]
			u_inst.global_scale.y = 1.0
			
		3:
			var r_inst = RightNote.instance()
			r_inst.add_child(e_inst)
			$"Right Track/Right Arrow/Right Notes Transform/Right Notes".add_child(r_inst)
			r_inst.hit_time = n_note[0]
			r_inst.live = true
			r_inst.hold_time = n_note[2]
			r_inst.hold_note = (n_note[2]>0)
			r_inst.position.y = n_note[0]
			r_inst.global_scale.y = 1.0
		


func load_notes():
	var file = File.new()
	file.open(chart_file, File.READ)
	var content = file.get_as_text()
	file.close()
	var file_chart_data = JSON.parse(content).result
#	editor_chart_data = file_chart_data
	
	if player_track:
		print("\n\nADDING PLAYER NOTES")
		for note_section in file_chart_data["song"]["notes"]:
	#		if "bpm" in note_section:
	#			BPM = note_section["bpm"]
	#			$"BPM/BPM".text = str(BPM)
			if note_section["mustHitSection"]:
				for note in note_section["sectionNotes"]:
					if note[1] <= 3:
						import_note(note)
						print("ADDIN PLAYER NOTE ", note)
				continue
			for note in note_section["sectionNotes"]:
				if note[1] > 3:
					import_note(note)
					print("99.8 ADDING PLAYER NOTE ", note)
			continue
		print("DONE ADDING PLAYER NOTES\n")
		return 0
	for note_section in file_chart_data["song"]["notes"]:
		if note_section["mustHitSection"]:
			for note in note_section["sectionNotes"]:
				if note[1] > 3:
					import_note(note)
					print("ADDING ENEMY NOTE", note)
#					print("ugdhg ", note)
			continue
#			return 0
		for note in note_section["sectionNotes"]:
			if note[0] < 3:
				import_note(note)
				print("ADDING ENEMY NOTE", note)
		continue

func get_notes():
	var notes = []
	notes.append_array($"Left Track/Left Arrow/Left Notes Transform/Left Notes".get_children())
	notes.append_array($"Down Track/Down Arrow/Down Notes Transform/Down Notes".get_children())
	notes.append_array($"Up Track/Up Arrow/Up Notes Transform/Up Notes".get_children())
	notes.append_array($"Right Track/Right Arrow/Right Notes Transform/Right Notes".get_children())
	return notes
# Called when the node enters the scene tree for the first time.

func clear_notes():
	var notes = get_notes()
	for note in notes:
		note.queue_free()

func get_left_notes():
	var notes = []
	notes.append_array($"Left Track/Left Arrow/Left Notes Transform/Left Notes".get_children())
	return notes
	


func get_down_notes():
	var notes = []
	notes.append_array($"Down Track/Down Arrow/Down Notes Transform/Down Notes".get_children())
	return notes
	

func get_up_notes():
	var notes = []
	notes.append_array($"Up Track/Up Arrow/Up Notes Transform/Up Notes".get_children())
	return notes
	

func get_right_notes():
	var notes = []
	notes.append_array($"Right Track/Right Arrow/Right Notes Transform/Right Notes".get_children())
	return notes
	


func _ready():
#	scroll_speed = scroll_speed
	set_scroll_speed(scroll_speed)
	if auto_load_chart:
		load_notes()

func recieve_input(event):
	pass

func recieve_hit(note : Note, hit_error):
	match note.note_type:
		0:
			$"Left Track/Left Arrow".play_hit()
		1:
			$"Down Track/Down Arrow".play_hit()
		2:
			$"Up Track/Up Arrow".play_hit()
		3:
			$"Right Track/Right Arrow".play_hit()

var YEAHIGOTIT = false
func recieve_songtime(s_time):
	set_song_time(s_time)
#	song_time = s_time
	if !YEAHIGOTIT:
		YEAHIGOTIT = true
		print("YEAHIGOTIT ", song_time)
#		print(self.print_tree())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
