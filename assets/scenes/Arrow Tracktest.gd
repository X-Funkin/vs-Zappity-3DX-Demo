extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var ughdsadfa setget set_ugh, get_ugh

func set_ugh(n_ugh):
	print("ogyfaioshf")
	for thing in get_children():
		print("thing ", thing.name)
	print($"Down Track/Down Arrow/Down Notes Transform/Down Notes".name)
func get_ugh():
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	for thing in get_children():
		print("thing ", thing.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
