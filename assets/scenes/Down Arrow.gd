extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_press():
	$"Down Arrow Animation".play("Down Arrow Press")

func play_hit():
	$"Down Arrow Animation".stop()
	$"Down Arrow Animation".play("Down Arrow Confirm")
	var note = OldNote.new()
	note.note_type = 1
	if get_parent().get_parent().player_track:
		get_tree().call_group("Player Hit Recievers", "recieve_player_hit", note, 0)
	else:
		get_tree().call_group("Enemy Hit Recievers", "recieve_enemy_hit", note, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_default():
	$"Down Arrow Animation".play("Down Arrow Default")

func _on_Down_Arrow_Animation_animation_finished(anim_name):
	if anim_name[-1] == "m":
		set_default()
