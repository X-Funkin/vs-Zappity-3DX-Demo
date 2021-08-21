extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func recieve_enemy_hit(note, hit_error):
	match note.note_type:
		0:
			get_child(0).play_animation("Left")
		1:
			get_child(0).play_animation("Donw")
		2:
			get_child(0).play_animation("Up")
		3:
			get_child(0).play_animation("Right")
		

func recieve_player_hit(note, hit_error):
	match note.note_type:
		0:
			get_child(0).play_animation("Left")
		1:
			get_child(0).play_animation("Donw")
		2:
			get_child(0).play_animation("Up")
		3:
			get_child(0).play_animation("Right")
		


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
