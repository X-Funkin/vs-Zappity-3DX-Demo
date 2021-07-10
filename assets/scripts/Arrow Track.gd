extends Node2D
class_name Arrow_Track

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var scroll_speed = 1.0 setget set_scroll_speed, get_scroll_speed
export(float) var song_time setget set_song_time, get_song_time
export(String) var chart_file
export(String) var chart_channel
#export(String) var input_receivers_group

var LeftNote : PackedScene = load("res://assets/scenes/Left Note.tscn")
var DownNote : PackedScene = load("res://assets/scenes/Down Note.tscn")
var UpNote : PackedScene = load("res://assets/scenes/Up Note.tscn")
var RightNote : PackedScene = load("res://assets/scenes/Right Note.tscn")
var EditorNote : PackedScene = load("res://assets/scenes/Editor Note.tscn")

func set_scroll_speed(n_speed):
	scroll_speed = n_speed
	for AFOSAHGD in get_children():
		print(AFOSAHGD.name)
	print(name)
	print($"Left Track".name)
	print($"Left Track/Left Arrow".name)
	print($"Left Track/Left Arrow/Left Notes Transform".name)
	print($"Left Track/Left Arrow/Left Notes Transform/Left Notes".name)
	print($"Left Track/Left Arrow/Left Notes Transform/Left Notes".name)
	$"Left Track/Left Arrow/Left Notes Transform".scale.y = scroll_speed
	$"Down Track/Down Arrow/Down Notes Transform".scale.y = scroll_speed
	$"Up Track/Up Arrow/Up Notes Transform".scale.y = scroll_speed
	$"Right Track/Right Arrow/Right Notes Transform".scale.y = scroll_speed
	
	for node in $"Left Track/Left Arrow/Left Notes Transform/Left Notes".get_children():
		node.scale.y = 1.0/scroll_speed
	for node in $"Down Track/Down Arrow/Down Notes Transform/Down Notes".get_children():
		node.scale.y = 1.0/scroll_speed
	for node in $"Up Track/Up Arrow/Up Notes Transform/Up Notes".get_children():
		node.scale.y = 1.0/scroll_speed
	for node in $"Right Track/Right Arrow/Right Notes Transform/Right Notes".get_children():
		node.scale.y = 1.0/scroll_speed
func get_scroll_speed():
	return scroll_speed

func set_song_time(n_time):
	song_time = n_time
	$"Left Track/Left Arrow/Left Notes Transform/Left Notes".position.y = -n_time
	$"Down Track/Down Arrow/Down Notes Transform/Down Notes".position.y = -n_time
	$"Up Track/Up Arrow/Up Notes Transform/Up Notes".position.y = -n_time
	$"Right Track/Right Arrow/Right Notes Transform/Right Notes".position.y = -n_time

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
		

func add_editor_note(n_note : Note):
	var e_inst = EditorNote.instance()
	match n_note.note_type:
		0:
			var l_inst = LeftNote.instance()
			l_inst.add_child(e_inst)
			l_inst.hit_time = n_note.hit_time
			l_inst.live = n_note.live
			$"Left Track/Left Arrow/Left Notes Transform/Left Notes".add_child(l_inst)
			l_inst.position.y = n_note.hit_time
			l_inst.global_scale.y = 1.0
			print("yeah added note lol ", l_inst.transform)
			print("lgobal ", l_inst.global_transform)
		1:
			var d_inst = DownNote.instance()
			d_inst.add_child(e_inst)
			d_inst.hit_time = n_note.hit_time
			d_inst.live = n_note.live
			print("DOWEAOSDFK")
			$"Down Track/Down Arrow/Down Notes Transform/Down Notes".add_child(d_inst)
			d_inst.position.y = n_note.hit_time
			d_inst.global_scale.y = 1.0
		2:
			var u_inst = UpNote.instance()
			u_inst.add_child(e_inst)
			u_inst.hit_time = n_note.hit_time
			u_inst.live = n_note.live
			$"Up Track/Up Arrow/Up Notes Transform/Up Notes".add_child(u_inst)
			u_inst.position.y = n_note.hit_time
			u_inst.global_scale.y = 1.0
		3:
			var r_inst = RightNote.instance()
			r_inst.add_child(e_inst)
			r_inst.hit_time = n_note.hit_time
			r_inst.live = n_note.live
			$"Right Track/Right Arrow/Right Notes Transform/Right Notes".add_child(r_inst)
			r_inst.position.y = n_note.hit_time
			r_inst.global_scale.y = 1.0
		

func get_notes():
	var notes = []
	notes.append_array($"Left Track/Left Arrow/Left Notes Transform/Left Notes".get_children())
	notes.append_array($"Down Track/Down Arrow/Down Notes Transform/Down Notes".get_children())
	notes.append_array($"Up Track/Up Arrow/Up Notes Transform/Up Notes".get_children())
	notes.append_array($"Right Track/Right Arrow/Right Notes Transform/Right Notes".get_children())
	return notes
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
