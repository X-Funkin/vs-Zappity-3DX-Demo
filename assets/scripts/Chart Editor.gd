extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var test = AudioStreamOGGVorbis.new()
var tast : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Right Note/AnimationPlayer".play("SPIIIIIN")
	pass
	
#	var test3 = bytes2var(testwav.data[0])
#	print(test3)
	#pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
		player_note_array += [[note.hit_time, note.note_type, note.hold_time]]
	player_note_array.sort_custom(Note_sorter, "sort_notes")
	
	var enemy_notes = $"Arrow Track2".get_notes()
	var enemy_note_array = []
	for note in enemy_notes:
		enemy_note_array += [[note.hit_time, note.note_type, note.hold_time]]
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
