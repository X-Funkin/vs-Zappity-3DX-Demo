extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var song_time = 0.0
var playing_snippet = false
func _process(delta):
	if playing and !playing_snippet:
		var current_time = get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
		var diff = current_time-song_time
		if diff < 0 and abs(diff)<0.3:
			current_time = song_time + delta
		song_time = current_time
		get_tree().call_group("Song Time Recievers", "recieve_songtime",1000.0*song_time-15.5*1.0)
#	pass
