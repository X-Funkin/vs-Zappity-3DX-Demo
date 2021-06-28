extends Node2D
class_name OS_Box

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var window_name setget set_name, get_name
export(int) var width setget set_w, get_w
export(int) var height setget set_h, get_h
export(PackedScene) var target_scene

func set_name(n_name):
	window_name = n_name
	#$Label.text = n_name

func get_name():
	return window_name

func set_w(n_width):
	width = n_width
func get_w():
	return width
	
func set_h(n_height):
	height = n_height
func get_h():
	return height
# Called when the node enters the scene tree for the first time.

func recieve_enter():
	$"OS Box Animation".play("Open Window")
	print("Playing OS Box thingy hopefully lol")
func _ready():
	var windowscene = target_scene.instance()
	$Viewport.add_child(windowscene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
