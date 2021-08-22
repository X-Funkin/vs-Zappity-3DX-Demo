extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$"VBoxContainer/FNF Text/Gameplay Options Button".grab_focus()
	if GameData.data.photosensitivity == 1:
		$"VBoxContainer/FNF Text6".text = "PHOTOSENSITIVE MODE ON"
		$"VBoxContainer/FNF Text6/Photosensitive Button".pressed = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().call_group("Menu Switchers", "switch_to_main")

func _on_Gameplay_Options_Button_pressed():
	get_tree().call_group("Options Menu Switchers", "switch_to_gameplay_options")
	
	pass # Replace with function body.

func _on_Controls_Options_Button_pressed():
	get_tree().call_group("Options Menu Switchers", "switch_to_control_options")
	pass # Replace with function body.


func _on_Chart_Editor_Button_pressed():
	get_tree().change_scene("res://assets/scenes/Chart Editor.tscn")
	pass # Replace with function body.



func _on_Photosensitive_Button_pressed():
	GameData.data.photosensitivity = 1
	pass # Replace with function body.


func _on_Photosensitive_Button_toggled(button_pressed):
	if button_pressed:
		GameData.data.photosensitivity = 1
		$"VBoxContainer/FNF Text6".text = "PHOTOSENSITIVE MODE ON"
	else:
		GameData.data.photosensitivity = 0
		$"VBoxContainer/FNF Text6".text = "PHOTOSENSITIVE MODE OFF"
	GameData.save_game_data()
	pass # Replace with function body.
