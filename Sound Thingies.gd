extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func play_miss():
	$"Player Miss Sound".stop()
	$"Player Miss Sound".play()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
