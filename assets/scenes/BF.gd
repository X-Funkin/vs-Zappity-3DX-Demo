extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func recieve_player_input(event: InputEvent):
	pass
var boppin = false
func recieve_player_hit(note : Note, error):
	boppin = false
	$"BF Animations".stop()
	match note.note_type:
		0:
			$"BF Animations".play("Note Left")
		1:
			$"BF Animations".play("Note Down")
		2:
			$"BF Animations".play("Note Up")
		3:
			$"BF Animations".play("Note Right")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
