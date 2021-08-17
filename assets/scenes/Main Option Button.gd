extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Color) var focused_color = Color(1,1,1,1)
export(Color) var unfocused_color = Color(1,1,1,0.5)


# Called when the node enters the scene tree for the first time.
func _ready():
	unfocused()
	connect("focus_entered", self,"focused")
	connect("focus_exited",self,"unfocused")
	pass # Replace with function body.


func focused():
	get_parent().modulate = focused_color
	pass

func unfocused():
	get_parent().modulate = unfocused_color
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
