extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(PackedScene) var target_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept") and $Label3.visible:
		$Label3/AnimationPlayer.stop()
		$Label3.modulate = Color(1,1,1)
		$Label3.text = "Loading..."
	if event.is_action_released("ui_accept") and $Label3.visible:
#		get_tree().change_scene("res://assets/scenes/Menu Screens.tscn")
		get_tree().change_scene_to(target_scene)
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Label3.visible = true
	$Label3/AnimationPlayer.play("text modulate lol")
	pass # Replace with function body.
