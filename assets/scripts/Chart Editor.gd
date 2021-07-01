extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var test = AudioStreamOGGVorbis.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	var test2 = load("res://assets/sounds/test.wav")
	var maax = test2.data[0]
	var miin = test2.data[0]
	
	for d in test2.data:
		maax = max(maax,d)
		miin = min(miin,d)
	print("UYDOFA ", maax, " ", miin)
	print(test2.data.hex_encode())
	print("\n\nZISE\n", test2.data.size())
	var test3 = bytes2var(test2.data[0])
	print(test3)
	#pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
