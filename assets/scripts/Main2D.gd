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

func color_arrow_box(arrow_box, note_type):
	match note_type:
		0:
			arrow_box.boarder_color = Color(1,0,1)
		1:
			arrow_box.boarder_color = Color(0,1,1)
		2:
			arrow_box.boarder_color = Color(0,1,0)
		3:
			arrow_box.boarder_color = Color(1,0,0)

func recieve_enemy_hit(note, hit_error):
	var arrow_box = $"Zappity Arrow Box"
	if GameData.data.photosensitivity == 0:
		color_arrow_box(arrow_box, note.note_type)

func recieve_player_hit(note, hit_error):
	var arrow_box = $"Player Arrow Box"
	if GameData.data.photosensitivity == 0:
		color_arrow_box(arrow_box, note.note_type)


func _on_Timer_timeout():
#	$"Player Arrow Box".open_window()
	pass # Replace with function body.
