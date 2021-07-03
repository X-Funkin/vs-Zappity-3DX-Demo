extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
export(float) var height setget set_height, get_height
export(float) var song_time setget set_song_time, get_song_time
export(float) var zoom_level setget set_zoom, get_zoom

func set_height(n_height):
	height = n_height
func get_height():
	return height


func set_song_time(n_time):
	song_time = n_time
func get_song_time():
	return song_time

func set_zoom(n_zoom):
	zoom_level = n_zoom
func get_zoom():
	return zoom_level

var testwav : AudioStreamSample = load("res://assets/sounds/zappity-voice.wav")

#var testwav : AudioStreamSample = load("res://assets/sounds/test.wav")
func update_transform():
	var top = height
	var bottom = -height
	var t0 = song_time-pow(10.0,zoom_level)
	var t1 = song_time+pow(10.0,zoom_level)
	transform.origin.y = -(-2.0*(height*height)/(t0-t1)+t0)
	transform.y.y = -2.0*height/(t0-t1)
#func _process(delta):
#	update_transform()
#	pass

var sample_start = 0
var sample_end = int(1543424)
var sample_step = 1
func _ready():
	var N = get_sample(100, testwav)
	print("imn the thign node bruh ")
	print(N)
	print(len(testwav.data))
	print(testwav.get_length())

func set_params():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_sample(sample : int, wav : AudioStreamSample):
	var buff = StreamPeerBuffer.new()
	match wav.format:
		wav.FORMAT_8_BITS:
			buff.data_array = [wav.data[sample]]
			return buff.get_8()
		wav.FORMAT_16_BITS:
			buff.data_array = [wav.data[sample*2], wav.data[sample*2+1]]
			return buff.get_16()
	
func get_sample_16(sample : int, wav : AudioStreamSample):
	
	var buff = StreamPeerBuffer.new()
	buff.data_array = [wav.data[sample*2], wav.data[sample*2+1]]
	return buff.get_16()

func get_stereo_sample_16(sample : int, wav : AudioStreamSample):
	var buff_x = StreamPeerBuffer.new()
	var buff_y = StreamPeerBuffer.new()
	buff_x.data_array = [wav.data[sample*4], wav.data[sample*4+1]]
	buff_y.data_array = [wav.data[sample*4+2], wav.data[sample*4+3]]
	return Vector2(buff_x.get_16(),buff_y.get_16())/32767.0

func get_right_sample_16(sample : int, wav : AudioStreamSample):
	var buff = StreamPeerBuffer.new()
	buff.data_array = [wav.data[sample*4+2], wav.data[sample*4+3]]
	return buff.get_16()/32767.0

func get_left_sample_16(sample : int, wav : AudioStreamSample):
	var buff = StreamPeerBuffer.new()
	buff.data_array = [wav.data[sample*4], wav.data[sample*4+1]]
	return buff.get_16()/32767.0

var t0 = 0
var t1 = 0
func _draw():
	var points : PoolVector2Array = []
#	var point = Vector2(1000.0*float(get_sample_16(sample_start, testwav))/32767.0, 0)
#	var point = Vector2(1000.0*get_stereo_sample_16(sample_start, testwav).x, 0)
	var point = Vector2(0, 0)
	var buff = StreamPeerBuffer.new()
	var wavdata = testwav.data
	t0 = OS.get_system_time_msecs()
	for sample in range(sample_start, sample_end):
#		points.append(Vector2(1000.0*float(get_sample_16(sample, testwav))/32767.0, float(sample)/1.0))
#		var new_point = Vector2(1000.0*float(get_sample_16(sample, testwav))/32767.0, float(sample)/1.0)
		buff.data_array = [wavdata[sample*4+2], wavdata[sample*4+3]]
		var new_point = Vector2(1000.0*buff.get_16()/32767.0, float(sample)/44100.0)
		draw_line(point, new_point, Color("FF0000"))
		point = new_point
#		points.append(Vector2(float(get_sample_16(sample, testwav))/32767.0, float(sample)/float(testwav.mix_rate)))
#	draw_polyline(points, Color("FF0000"))
	t1 = OS.get_system_time_msecs()
	print("END POINT OF YEAH, ", point)
	var dt = t1-t0
	print("drawing all ", sample_end - sample_start, " samples took ", float(dt)/1000.0, " seconds, so")
	print(float(sample_end - sample_start)/(float(dt)/1000.0), " samples per second to draw")

func drawlmao():
	var points : PoolVector2Array = []
#	var point = Vector2(1000.0*float(get_sample_16(sample_start, testwav))/32767.0, 0)
#	var point = Vector2(1000.0*get_stereo_sample_16(sample_start, testwav).x, 0)
	var point = Vector2(1000.0*get_right_sample_16(sample_start, testwav), 0)
	t0 = OS.get_system_time_msecs()
	for sample in range(sample_start, sample_end):
#		points.append(Vector2(1000.0*float(get_sample_16(sample, testwav))/32767.0, float(sample)/1.0))
#		var new_point = Vector2(1000.0*float(get_sample_16(sample, testwav))/32767.0, float(sample)/1.0)
		var new_point = Vector2(1000.0*get_right_sample_16(sample, testwav), float(sample)/1.0)
		draw_line(point, new_point, Color("FF0000"))
		point = new_point
#		points.append(Vector2(float(get_sample_16(sample, testwav))/32767.0, float(sample)/float(testwav.mix_rate)))
#	draw_polyline(points, Color("FF0000"))
	t1 = OS.get_system_time_msecs()
	print("END POINT OF YEAH, ", point)
	var dt = t1-t0
	print("drawing all ", sample_end - sample_start, " samples took ", float(dt)/1000.0, " seconds, so")
	print(float(sample_end - sample_start)/(float(dt)/1000.0), " samples per second to draw")



func drawlol():
	var points : PoolVector2Array = []
	for sample in range(sample_start, sample_end, sample_step):
		points.append(Vector2(1000.0*float(get_sample_16(sample, testwav))/32767.0, float(sample)/1.0))
#		points.append(Vector2(float(get_sample_16(sample, testwav))/32767.0, float(sample)/float(testwav.mix_rate)))
	draw_polyline(points, Color("FF0000"))
