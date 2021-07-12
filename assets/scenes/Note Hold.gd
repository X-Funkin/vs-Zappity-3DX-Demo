extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hold_time : float setget set_hold_time, get_hold_time
var played_time = 0.0 setget set_played_time, get_played_time

func set_hold_time(n_time):
#	print("get_child(0).get_child(1) ", get_child(0).get_child(1).name)
#	print("get_child(0).get_child(0) ", get_child(0).get_child(0).name)
	get_child(0).get_child(0).scale.y = n_time/44.0
	get_child(0).get_child(0).get_child(0).global_scale.y = 1.0
	hold_time = n_time

func get_hold_time():
	return hold_time

func set_played_time(n_time):
	played_time = n_time
	var time_left = hold_time-played_time
	get_child(0).get_child(0).scale.y = time_left/44.0
	get_child(0).get_child(0).get_child(0).global_scale.y = 1.0
#	get_child(0).get_child(1).position.y = time_left/44.0
func get_played_time():
	return played_time

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func scale_set(n_scale):
#	print("SADCLFJIOLSADHFIUA ", n_scale)
	get_child(0).scale.y = n_scale
	get_child(0).get_child(0).get_child(0).global_scale.y = 1.0
#	get_child(0).get_child(1).scale.y = 1.0/n_scale
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
