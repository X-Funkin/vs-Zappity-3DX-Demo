extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	$Particles.emitting = true
	$AnimationPlayer.playback_speed = 1/120.0
	$AnimationPlayer.play("orbiiit")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
