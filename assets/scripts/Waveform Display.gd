extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(AudioStreamSample) var wav_file
export(float) var swap_start_ms = 4000.0
export(float) var swap_end_ms = 5000.0
var visible_length_ms setget set_visible_length, get_visible_length

var waveamp : PackedScene = load("res://assets/scenes/Waveform Amplitude.tscn")
var wavevis : PackedScene = load("res://assets/scenes/Waveform Visualizer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var ampinst = waveamp.instance()
	var visinst = wavevis.instance()
	ampinst.wavefile = wav_file
	visinst.wav_file = wav_file
	ampinst.name = "Waveform Amplitude"
	visinst.name = "Waveform Visualizer"
	add_child(ampinst)
	add_child(visinst)

func set_visible_length(n_length):
	print("new visible length ", n_length)
	visible_length_ms = n_length
	if visible_length_ms >= swap_end_ms:
		print("yeah it's >= swap end ", swap_end_ms)
#		$"Waveform Visualizer".visible = false
		$"Waveform Amplitude".modulate.a = 1.0
		return 0
	if visible_length_ms <= swap_start_ms:
		print("yeah it's <= swap start ", swap_start_ms)
#		$"Waveform Amplitude".visible = false
		$"Waveform Amplitude".modulate.a = 0.0
		return 0
	print("oh hey it' neither")
	var mix = clamp(inverse_lerp(swap_start_ms,swap_end_ms,visible_length_ms), 0.0, 1.0)
	print("mix factor is ", mix)
	$"Waveform Visualizer".visible = true
	$"Waveform Amplitude".visible = true
	$"Waveform Amplitude".modulate.a = mix

func get_visible_length():
	return visible_length_ms
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
