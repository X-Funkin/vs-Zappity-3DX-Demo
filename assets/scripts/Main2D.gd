extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	$"Zappity Arrow Box".open_window()
#	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func recieve_count_down(count_down):
	match count_down:
		1:
			$"Zappity Arrow Box".open_window()
			$"Player Arrow Box".open_window()
#		1:
			$"Countdown Box".close_window()
		6:
			$"Countdown Box".open_window()

func recieve_song_finished():
	$"Zappity Arrow Box".close_window()
	$"Player Arrow Box".close_window()
	$"Score Box".open_window()

func _on_Timer_timeout():
#	$"Player Arrow Box".open_window()
	pass # Replace with function body.
