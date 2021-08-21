extends Character


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func realign_sprite(): #Realigns the sprite to the set aligment
	if sprite_realignment:
		var character_node : AnimatedSprite = get_node(character_sprite)
		var sprite_frame = character_node.frames.get_frame(character_node.animation,character_node.frame)
		var center_offset = Vector2()
		if !custom_alignment:
			match sprite_vertical_alignment:
				0:
					center_offset.y = -sprite_frame.get_size().y/2.0
				2:
					center_offset.y = sprite_frame.get_size().y/2.0
			match sprite_horizontal_alignment:
				0:
					center_offset.x = sprite_frame.get_size().x/2.0
				2:
					center_offset.x = -sprite_frame.get_size().x/2.0
		else:
			center_offset.x = custom_horizontal_alignment*sprite_frame.get_size().x/2.0
			center_offset.y = -custom_vertical_alignment*sprite_frame.get_size().y/2.0
		character_node.offset = center_offset
		character_node.material.set_shader_param("Sprite_Texture", sprite_frame)
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
