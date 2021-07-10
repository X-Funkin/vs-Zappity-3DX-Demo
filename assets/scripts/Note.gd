extends Node2D
class_name Note

export(float) var hit_time
export(float) var hold_time
export(int) var note_type
export(bool) var live
export(bool) var player_note
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = true
var enemy_hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if live:
		if -get_parent().position.y > hit_time and active:
			visible = false
			get_parent().get_parent().get_parent().play_hit()
			active = false
			return 0
		if -get_parent().position.y <= hit_time and !active:
			active = true
			visible = true
			return 0
#	pass
