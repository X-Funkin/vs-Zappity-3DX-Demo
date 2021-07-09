extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_hit():
	$"Left Arrow Animation".stop()
	$"Left Arrow Animation".play("Left Arrow Confirm")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_default():
	$"Left Arrow Animation".play("Left Arrow Default")

func _on_Left_Arrow_Animation_animation_finished(anim_name):
	set_default()
