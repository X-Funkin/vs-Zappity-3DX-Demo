extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.position.y *= GameData.data.settings.scroll_direction
	$"Judgment Particles".position.y *= GameData.data.settings.scroll_direction
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
