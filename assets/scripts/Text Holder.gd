extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("yea event")
		$TextAnim.play("Print Text")
func recieve_enter():
	print("yea enter")
	$TextAnim.play("Print Text")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
