extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sample_start = 0
var sample_end = 44100
var wavefile : AudioStreamSample

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var wavedata = wavefile.data
	var sample_rate = wavefile.mix_rate
	var buff = StreamPeerBuffer.new()
	var point : Vector2
	if wavefile.stereo:
		if wavefile.format == 1:
			buff.data_array = [wavedata[sample_start*4+2], wavedata[sample_start*4+3]]
			point = Vector2(1000.0*buff.get_16()/32767.0, 0.0)
			for sample in range(sample_start+1, sample_end):
				buff.data_array = [wavedata[sample*4+2], wavedata[sample*4+3]]
				var new_point = Vector2(1000.0*buff.get_16()/32767.0, 1000.0*float(sample-sample_start)/float(sample_rate))
				draw_line(point, new_point, Color(1,1,1))
				point = new_point
			return 1
		buff.data_array = [wavedata[sample_start*2+1]]
		point = Vector2(1000.0*buff.get_8()/127.0, 0.0)
		for sample in range(sample_start+1, sample_end):
			buff.data_array = [wavedata[sample*2+1]]
			var new_point = Vector2(1000.0*buff.get_8()/127.0, 1000.0*float(sample-sample_start)/float(sample_rate))
			draw_line(point, new_point, Color(1,1,1))
			point = new_point
		return 1
	if wavefile.format == 1:
		buff.data_array = [wavedata[sample_start*2], wavedata[sample_start*2+1]]
		point = Vector2(1000.0*buff.get_16()/32767.0, 0.0)
		for sample in range(sample_start+1, sample_end):
			buff.data_array = [wavedata[sample*2], wavedata[sample*2+1]]
			var new_point = Vector2(1000.0*buff.get_16()/32767.0, 1000.0*float(sample-sample_start)/float(sample_rate))
			draw_line(point, new_point, Color(1,1,1))
			point = new_point
		return 1
	buff.data_array = [wavedata[sample_start]]
	point = Vector2(1000.0*buff.get_8()/127.0, 0.0)
	for sample in range(sample_start+1, sample_end):
		buff.data_array = [wavedata[sample]]
		var new_point = Vector2(1000.0*buff.get_8()/127.0, 1000.0*float(sample-sample_start)/float(sample_rate))
		draw_line(point, new_point, Color(1,1,1))
		point = new_point
	return 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
