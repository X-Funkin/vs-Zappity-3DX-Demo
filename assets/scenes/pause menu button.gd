extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	unfocused()
	connect("focus_entered", self, "focused")
	connect("focus_exited", self, "unfocused")
	pass # Replace with function body.


func focused():
	get_parent().modulate = Color(1,1,1,1)

func unfocused():
	get_parent().modulate = Color(1,1,1,0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
