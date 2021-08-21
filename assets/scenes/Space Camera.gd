extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func recieve_camera_transform(c_transform):
	transform = c_transform

func recieve_camera(camera):
	fov = camera.fov
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
