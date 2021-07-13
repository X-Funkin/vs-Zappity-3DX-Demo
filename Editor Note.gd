extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Note_Area_mouse_entered():
	print("hovering over editor note lol")
	get_parent().modulate = Color("FFFF00")


func _on_Note_Area_mouse_exited():
	get_parent().modulate = Color("FFFFFF")


func _on_Note_Area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_RIGHT:
			if Input.is_key_pressed(KEY_SHIFT):
				get_parent().hold_note = false
				return 0
			get_parent().queue_free()
