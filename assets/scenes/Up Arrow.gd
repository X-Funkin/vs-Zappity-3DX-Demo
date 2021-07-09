extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_hit():
	$"Up Arrow Animation".stop()
	$"Up Arrow Animation".play("Up Arrow Confirm")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_default():
	$"Up Arrow Animation".play("Up Arrow Default")

func _on_Up_Arrow_Animation_animation_finished(anim_name):
	set_default()
