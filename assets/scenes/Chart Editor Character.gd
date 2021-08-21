extends Node2D
export(NodePath) var character_node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func recieve_enemy_hit(note, hit_error):
	match note.note_type:
		0:
			get_node(character_node).play_animation("Left")
		1:
			get_node(character_node).play_animation("Donw")
		2:
			get_node(character_node).play_animation("Up")
		3:
			get_node(character_node).play_animation("Right")
		
	$"Pose Timer".start()

func recieve_player_hit(note, hit_error):
	match note.note_type:
		0:
			get_node(character_node).play_animation("Left")
		1:
			get_node(character_node).play_animation("Donw")
		2:
			get_node(character_node).play_animation("Up")
		3:
			get_node(character_node).play_animation("Right")
	$"Pose Timer".start()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pose_Timer_timeout():
	get_node(character_node).play_animation("Idle")
	pass # Replace with function body.


func _on_FileDialog_file_selected(path):
	var thing : Node2D = load(path).instance()
	add_child(thing)
	get_node(character_node).queue_free()
	character_node = thing.get_path()
	pass # Replace with function body.


func _on_Load_Character_pressed():
	$FileDialog.popup()
	pass # Replace with function body.


func _on_LineEdit_text_entered(new_text):
	get_node(character_node).scale = Vector2(float(new_text),float(new_text))
	pass # Replace with function body.


func _on_CheckBox_toggled(button_pressed):
	get_node(character_node).visible = button_pressed
	pass # Replace with function body.
