extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var offset = 0.0
export(float) var speed = 1.0 setget set_speed, get_speed

func set_speed(n_speed):
	speed = n_speed
	if yeah_ready:
		$"Zappity Voice".pitch_scale = n_speed
		$"BF Voice".pitch_scale = n_speed
		$"Instrumentals".pitch_scale = n_speed

func get_speed():
	return speed

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Zappity Voice".play()
	$"BF Voice".play()
	$"Instrumentals".play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
var prev_song_time = 0.0
var frames_since = 0
var yeah_ready = false
func _process(delta):
	yeah_ready = true
	var song_time = $Instrumentals.get_playback_position()+AudioServer.get_time_since_last_mix()-AudioServer.get_output_latency()
	if song_time < prev_song_time:
#		print("IT BEFOR WHY? ", prev_song_time-song_time)
		if prev_song_time-song_time > 1.0:
#			print("RESTARTING")
			prev_song_time = 0.0
			song_time = 0.0
		song_time = prev_song_time + delta*speed
#		print("a solid ", frames_since, " frame since song_time was weird")
		frames_since = 0
#		if prev_song_time - song_time < 
	frames_since += 1
	get_tree().call_group("Song Time Recievers", "recieve_songtime", 1000.0*song_time+offset)
	prev_song_time = song_time
#	pass


func _on_Instrumentals_finished():
#	prev_song_time = -1.0
	pass
