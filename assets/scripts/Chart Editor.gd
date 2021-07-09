extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var test = AudioStreamOGGVorbis.new()
var tast : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
#	$"Right Note/AnimationPlayer".play("SPIIIIIN")
	pass
	
#	var test3 = bytes2var(testwav.data[0])
#	print(test3)
	#pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func play():
	var start_time = song_time_transform(0.0)
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
