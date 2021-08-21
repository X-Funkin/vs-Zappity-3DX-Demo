extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func recieve_player_judgment(judgment):
	var col = Color("FF0000")
	match judgment:
		5:
			col = Color("00FFFF")
		4:
			col = Color("FFFFFF")
		3:
			col = Color("00FF00")
		2:
			col = Color("FF0000")
	self_modulate = col
func recieve_player_hit(note, hit_error):
	text = "%5.4f ms"%hit_error
	$AnimationPlayer.stop()
	$AnimationPlayer.play("Hit")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
