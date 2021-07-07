extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var test = AudioStreamOGGVorbis.new()
var tast : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$"Arrow Track/AnimationPlayer".play("scaling ithaisgfnl")
	pass
	var test2 = load("res://assets/sounds/test.wav")
	var testwav : AudioStreamSample = load("res://assets/sounds/test.wav")
	var testogg : AudioStreamOGGVorbis = load("res://assets/sounds/test.ogg")
#	var testtste : AudioStreamPreview
#	var testpregen : AudioStreamPreviewGenerator
	var maax = testwav.data[0]
	var miin = testwav.data[0]
	
	for d in testwav.data:
		maax = max(maax,d)
		miin = min(miin,d)
	print("UYDOFA ", maax, " ", miin)
#	print(testwav.data.hex_encode())
	print("\n\nZISE\n", testwav.data.size())
	print("format: ", testwav.format)
	var spb = StreamPeerBuffer.new()
	spb.data_array = testwav.data
	var testarrayyys = [0,1,2,3,4,5]
#	print("yeah trying to convet lol ")
#	var intbois = PoolIntArray(spb.data_array)
#	print("done lol")
#	for i in intbois:
#		print(i)
	var floatbois = spb.get_16()
	print(floatbois)
	var check = 0
	var intarrs = []
	var i = testwav.data.size()
	i = i/2
	for I in range(0,i):
		break
		check += 1
		var J = I*2
		var lilarr : PoolByteArray = []
		lilarr.append(testwav.data[J])
		lilarr.append(testwav.data[J+1])
		var streambuffer = StreamPeerBuffer.new()
		streambuffer.data_array = lilarr
		intarrs.append(streambuffer.get_16())
		if check > 1000:
			print("yeah we're ", I, " in, that's about %3.5f"%(100.0*float(I)/float(i)), "%")
			streambuffer.data_array = lilarr
			print("current sample is ", streambuffer.get_16())
			check = 0
		#print("streambuffer.get_16(); ", streambuffer.get_16())
	print(len(intarrs))
	print(intarrs.max(), " ", intarrs.min())
	for ints in intarrs:
		print(ints)
	
#	var test3 = bytes2var(testwav.data[0])
#	print(test3)
	#pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
