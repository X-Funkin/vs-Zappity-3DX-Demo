#tool
extends Character3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#export(float) var testst


func play_animation(anim):
	var character_node : AnimatedSprite = get_node(character_sprite)
	character_node.stop()
	character_node.play(anim)
	$AnimationPlayer.stop()
	if $AnimationPlayer.has_animation(anim):
		$AnimationPlayer.play(anim)
	else:
		$AnimationPlayer.play("Default")

func play_input_animation(anim, pressed):
	if player or true:
		var character_node : AnimatedSprite = get_node(character_sprite)
		if pressed:
			if character_node.animation != anim:
				character_node.stop()
				character_node.play(anim)
				$AnimationPlayer.stop()
				if $AnimationPlayer.has_animation(anim):
					$AnimationPlayer.play(anim)
				else:
					$AnimationPlayer.play("Default")
		elif character_node.animation == anim:
			character_node.stop()
			character_node.play("Default")
			$AnimationPlayer.stop()
			$AnimationPlayer.play("Default")
		realign_sprite()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
