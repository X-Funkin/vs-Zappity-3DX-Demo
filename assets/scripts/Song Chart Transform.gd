extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var song_time setget set_song_time, get_song_time
export(float) var zoom_level setget set_zoom, get_zoom


func set_song_time(n_time):
	song_time = n_time
func get_song_time():
	return song_time

func set_zoom(n_zoom):
	zoom_level = n_zoom
func get_zoom():
	return zoom_level

func zoom(pos, zoom_lvl):
#	var song_zero = $"Song Position".global_transform.xform_inv(Vector2(0,0))
#	scale.y *= pow(10.0,zoom_lvl)
	#transform.y.y *= pow(10.0,zoom_lvl)
#	return 0
	var song_zero = $"Song Position".global_transform.affine_inverse()*Vector2(0,0)
	print("SONG ZERO: ", song_zero)
	var local_cursor = $"Song Position".global_transform.affine_inverse()*Vector2(0,pos)
	print("LOCAL CURSOR POSITION: ", local_cursor)
	scale.y *= 1.0+zoom_lvl
	var new_cursor = $"Song Position".global_transform.affine_inverse()*Vector2(0,pos)
	print("NEW CURSOR POSITTION: ", new_cursor)
	var new_song_zero = $"Song Position".global_transform.affine_inverse()*Vector2(0,0)
	print("NEW SONG ZERO: ", new_song_zero)
	print("DIFF: ", new_cursor.y-local_cursor.y)
	$"Song Position".position.y += new_cursor.y-local_cursor.y
	print("song position ", $"Song Position".position.y)
	#$"Song Position".position.y -= new_cursor.y-local_cursor.y
	$"Song Position/Waveform Display".set_visible_length(1000.0/scale.y)
func scroll(pxl):
	var offset = Vector2(0,pxl)/$"Song Position".global_scale
	$"Song Position".position.y += offset.y
	
var zoom_speed = 0.1
var scroll_speed = 50
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		print(event.as_text())
		print("pos ", get_global_mouse_position())
		if event.button_index == BUTTON_WHEEL_UP:
			if Input.is_key_pressed(KEY_SHIFT):
				zoom(get_global_mouse_position().y, zoom_speed)
			else:
				scroll(scroll_speed)
		if event.button_index == BUTTON_WHEEL_DOWN:
			if Input.is_key_pressed(KEY_SHIFT):
				zoom(get_global_mouse_position().y, -zoom_speed)
			else:
				scroll(-scroll_speed)
	if event.is_action_pressed("ui_accept"):
		print("\n\nZOOM IN")
		zoom(512, zoom_speed)
		
	if event.is_action_pressed("ui_cancel"):
		print("\n\nZOOM OUT")
		zoom(512, -zoom_speed)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
