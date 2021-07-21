extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(AudioStreamSample) var wav_file : AudioStreamSample
export(int) var chunk_size = 44100
export(bool) var auto_draw = true
var wavechunk : PackedScene = load("res://assets/scenes/Waveform Chunk.tscn")

# Called when the node enters the scene tree for the first time.
func draw_waveforms():
	if wav_file != null:
		var num = 1
		if (wav_file.stereo and wav_file.format == 0) or (!wav_file.stereo and wav_file.format == 1):
			num = 2
		if (wav_file.stereo and wav_file.format == 1):
			num = 4
		var final_sample = len(wav_file.data)/num
		var current_sample = 0
		while current_sample < final_sample:
			var new_sample = min(current_sample + chunk_size, final_sample)
			var waveinst = wavechunk.instance()
			waveinst.sample_start = current_sample
			waveinst.sample_end = new_sample
			waveinst.wavefile = wav_file
			waveinst.position.y = 1000.0*float(current_sample)/float(wav_file.mix_rate)
			add_child(waveinst)
			current_sample = new_sample

func clear_waveforms():
	for node in get_children():
		node.queue_free()

func reload_waveforms():
	clear_waveforms()
	draw_waveforms()

func _ready():
	if auto_draw:
		draw_waveforms()
#var sample_start = 0
#var sample_end = 44100
#var wavefile : AudioStreamSample
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
