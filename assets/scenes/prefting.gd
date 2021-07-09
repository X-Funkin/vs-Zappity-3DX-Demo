extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var frame_rate = Performance.get_monitor(Performance.TIME_FPS)
	var memory_use = Performance.get_monitor(Performance.MEMORY_STATIC)
	$HBoxContainer/VBoxContainer/fps.text = "Frame Rate: %s FPS"%frame_rate
	$HBoxContainer/VBoxContainer/mem.text = "Memory Use: %7.4f MB"%(float(memory_use)/1048576.0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
