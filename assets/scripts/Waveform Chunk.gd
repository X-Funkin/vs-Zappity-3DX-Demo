extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sample_start = 0
var sample_end = 44100
var wavefile : AudioStreamSample
# Called when the node enters the scene tree for the first time.
func _ready():
	$"Wave".wavefile = wavefile
	$"Wave".sample_start = sample_start
	$"Wave".sample_end = sample_end
	
	
#	return 0
#	$"Visibility Switch/Wave".wavefile = wavefile
#	$"Visibility Switch/Wave".sample_start = sample_start
#	$"Visibility Switch/Wave".sample_end = sample_end
#
#	$"Visibility Switch".rect.size.y = 500+100.0*(sample_end-sample_start)/float(wavefile.mix_rate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
