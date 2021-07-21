extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta):
	$"Up Note".position.y = get_parent().get_parent().song_cursor
#	$"Up Note".position.y = get_global_mouse_position().y

func mouse_entered():
	print("|ya eahy")

func _on_Player_Editor_Area_mouse_entered():
	print("ye aaahh")
	$"Up Note".visible = true


func _on_Player_Editor_Area_mouse_exited():
	print("AAE AOEOAE AEOOOA AA EOAAA EOOOEE EE")
	$"Up Note".visible = false


signal placed_note(note, pos)
signal added_hold
func _on_Player_Editor_Area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		print(event.as_text())
		print("pos ", get_global_mouse_position())
		var click_song_pos = get_parent().get_parent().song_time_transform(get_parent().get_parent().song_cursor)
		if event.button_index == BUTTON_LEFT:
			if Input.is_key_pressed(KEY_SHIFT):
				var notes = get_parent().get_up_notes()
				if notes != []:
					var nearest_note : Note = notes[0]
					for note in notes:
						if note.hit_time < click_song_pos:
							if note.hit_time > nearest_note.hit_time:
								nearest_note = note
					if nearest_note.hit_time < click_song_pos:
						nearest_note.hold_note = true
						nearest_note.hold_time = click_song_pos-nearest_note.hit_time
						emit_signal("added_hold")
				return 0
		if event.button_index == BUTTON_LEFT:
			print("left click at ", get_global_mouse_position())
			var n_note = Note.new()
			n_note.note_type = 2
			n_note.live = true
			n_note.hit_time = click_song_pos
			n_note.hold_note = false
			n_note.hold_time = 1000.0
			print("n_notehiteimg ", n_note.hit_time)
			get_parent().add_editor_note(n_note)
