#tool
extends Node2D
class_name OS_Box

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var window_name setget set_name, get_name
export(int) onready var width setget set_w, get_w
export(int) onready var height setget set_h, get_h
export(int) var display_width setget set_display_w, get_display_w
export(int) var display_height setget set_display_h, get_display_h
export(PackedScene) var target_scene

var ugh : bool = Engine.editor_hint

func set_name(n_name):
	window_name = n_name
	#$Label.text = n_name

func get_name():
	return window_name

func set_w(n_width):
	width = n_width
	if ugh:
		$"OS Box Borders".points[3].x = width
		$"OS Box Borders".points[4].x = width
		$Viewport.size.x = width
		$"Window Contents".mesh.size.x = width
		$"Window Contents".position.x = float(width)/2.0
func get_w():
	return width
	
func set_h(n_height):
	height = n_height
	if ugh:
		$"OS Box Borders".points[4].y = height
		$"OS Box Borders".points[5].y = height
		$Viewport.size.y = height
		$"Window Contents".mesh.size.y = height
		$"Window Contents".position.y = float(height)/2.0
func get_h():
	return height
	

func set_display_w(n_width):
	display_width = n_width
func get_display_w():
	return display_width
	
func set_display_h(n_height):
	display_height = n_height
func get_display_h():
	return display_height
# Called when the node enters the scene tree for the first time.

func recieve_enter():
	$"OS Box Animation".play("Open Window")
	print("Playing OS Box thingy hopefully lol")
func _ready():
	var windowscene = target_scene.instance()
	$Viewport.add_child(windowscene)
	ugh = true
	width = width
	height = height
	set_w(width)
	set_h(height)
#	$"OS Box Animation".play("Window Default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
