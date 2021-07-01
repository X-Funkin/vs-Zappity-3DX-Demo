extends Node2D
class_name Arrow_Track

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var scroll_speed setget set_scroll_speed, get_scroll_speed

func set_scroll_speed(n_speed):
	scroll_speed = n_speed
func get_scroll_speed():
	return scroll_speed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
