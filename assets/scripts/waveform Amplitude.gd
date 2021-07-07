extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

export(AudioStreamSample) var wavefile : AudioStreamSample
export(float) var bar_width_ms = 100.0
func _ready():
	pass # Replace with function body.

func _draw():
	var wavedata = wavefile.data
	var sample_rate = wavefile.mix_rate
	var bar_sample_width = int(bar_width_ms*float(sample_rate)/1000.0)
	var buff = StreamPeerBuffer.new()
	var point : Vector2
	var sample_current = 0
	var num = 1
	if (wavefile.stereo and wavefile.format == 0) or (!wavefile.stereo and wavefile.format == 1):
		num = 2
	if (wavefile.stereo and wavefile.format == 1):
		num = 4
	var sample_length = len(wavefile.data)/num
	var max_amp = 0
	var min_amp = 0
	if wavefile.stereo:
		if wavefile.format == 1:
			while sample_current < sample_length:
				var sample_start = sample_current
				var sample_end = min(sample_current+bar_sample_width,sample_length)
				
				buff.data_array = [wavedata[sample_start*4+2], wavedata[sample_start*4+3]]
				max_amp = buff.get_16()
				min_amp = max_amp
				for sample in range(sample_start+1, sample_end):
					buff.data_array = [wavedata[sample*4+2], wavedata[sample*4+3]]
					var amp = buff.get_16()
					max_amp = max(max_amp, amp)
					min_amp = min(min_amp, amp)
				point = Vector2(1000.0*min_amp/32767.0, 1000.0*float(sample_end+sample_start)/float(2*sample_rate))
				var new_point = Vector2(1000.0*max_amp/32767.0, 1000.0*float(sample_end+sample_start)/float(2*sample_rate))
				draw_line(point, new_point, Color(1,1,1),bar_width_ms)
				sample_current = sample_end
#				point = new_point
			return 1
		while sample_current < sample_length:
			var sample_start = sample_current
			var sample_end = min(sample_current+bar_sample_width,sample_length)
			
			buff.data_array = [wavedata[sample_start*2+1]]
			max_amp = buff.get_8()
			min_amp = max_amp
			for sample in range(sample_start+1, sample_end):
				buff.data_array = [wavedata[sample*2+1]]
				var amp = buff.get_8()
				max_amp = max(max_amp, amp)
				min_amp = min(min_amp, amp)
			point = Vector2(1000.0*min_amp/127.0, 1000.0*float(sample_end+sample_start)/float(2*sample_rate))
			var new_point = Vector2(1000.0*max_amp/127.0, 1000.0*float(sample_end+sample_start)/float(2*sample_rate))
			draw_line(point, new_point, Color(1,1,1),bar_width_ms)
			sample_current = sample_end
#				point = new_point
		return 1
	if wavefile.format == 1:
		while sample_current < sample_length:
			var sample_start = sample_current
			var sample_end = min(sample_current+bar_sample_width,sample_length)
			
			buff.data_array = [wavedata[sample_start*2], wavedata[sample_start*2+1]]
			max_amp = buff.get_16()
			min_amp = max_amp
			for sample in range(sample_start+1, sample_end):
				buff.data_array = [wavedata[sample*2], wavedata[sample*2+1]]
				var amp = buff.get_16()
				max_amp = max(max_amp, amp)
				min_amp = min(min_amp, amp)
			point = Vector2(1000.0*min_amp/32767.0, 1000.0*float(sample_end+sample_start)/float(2*sample_rate))
			var new_point = Vector2(1000.0*max_amp/32767.0, 1000.0*float(sample_end+sample_start)/float(2*sample_rate))
			draw_line(point, new_point, Color(1,1,1),bar_width_ms)
			sample_current = sample_end
		return 1
	while sample_current < sample_length:
		var sample_start = sample_current
		var sample_end = min(sample_current+bar_sample_width,sample_length)
		
		buff.data_array = [wavedata[sample_start]]
		max_amp = buff.get_8()
		min_amp = max_amp
		for sample in range(sample_start+1, sample_end):
			buff.data_array = [wavedata[sample]]
			var amp = buff.get_8()
			max_amp = max(max_amp, amp)
			min_amp = min(min_amp, amp)
		point = Vector2(1000.0*min_amp/127.0, 1000.0*float(sample_end+sample_start)/float(2*sample_rate))
		var new_point = Vector2(1000.0*max_amp/127.0, 1000.0*float(sample_end+sample_start)/float(2*sample_rate))
		draw_line(point, new_point, Color(1,1,1),bar_width_ms)
		sample_current = sample_end
	return 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
