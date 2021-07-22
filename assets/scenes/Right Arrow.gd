extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_press():
	$"Right Arrow Animation".play("Right Arrow Press")


func play_hit():
	$"Right Arrow Animation".stop()
	$"Right Arrow Animation".play("Right Arrow Confirm")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_default():
	$"Right Arrow Animation".play("Right Arrow Default")

func _on_Right_Arrow_Animation_animation_finished(anim_name):
	if anim_name[-1] == "m":
		set_default()
