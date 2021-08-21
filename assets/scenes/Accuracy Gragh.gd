#tool
extends Node2D


export(float) var height = 400
export(float) var width = 500
export(float) var line_width = 4
export(float) var point_size = 2
export(float) var label_margin = 10
export(float) var timing_window = 120
export(float) var max_timing = 16.5
export(float) var sick_timing = 40.5
export(float) var good_timing = 73.5
export(float) var bad_timing = 103.5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hits = []

class hit_sorter:
	static func sort_hits(a,b):
		return a[0]<b[0]

func sort_hits():
	hits.sort_custom(hit_sorter, "sort_hits")

func update_label(label, pos):
	var plus_label : Label = get_node("Control/+"+label)
	var minus_label = get_node("Control/-"+label)
	plus_label.rect_size = Vector2(0,0)
	minus_label.rect_size = Vector2(0,0)
	print("\ntrying to move to ", pos)
	plus_label.rect_position.y=-pos.y-plus_label.rect_size.y/2.0
	plus_label.rect_position.x=pos.x-plus_label.rect_size.x
	minus_label.rect_position.y=pos.y-minus_label.rect_size.y/2.0
	minus_label.rect_position.x=pos.x-minus_label.rect_size.x
	print(plus_label.name, " plus pos check", plus_label.rect_position+plus_label.rect_size/2.0)
	print(minus_label.name, " minus pos check", minus_label.rect_position+minus_label.rect_size/2.0)

func update_max_labels():
	$"Control/+Max Time".text = "+%s ms"%max_timing
	$"Control/-Max Time".text = "-%s ms"%max_timing
	var y_pos = range_lerp(max_timing,-timing_window,timing_window,-height/2.0,height/2.0)
	update_label("Max Time", Vector2(-width/2.0-label_margin, y_pos))
	pass

func update_sick_labels():
	$"Control/+Sick Time".text = "+%s ms"%sick_timing
	$"Control/-Sick Time".text = "-%s ms"%sick_timing
	var y_pos = range_lerp(sick_timing,-timing_window,timing_window,-height/2.0,height/2.0)
	update_label("Sick Time", Vector2(-width/2.0-label_margin, y_pos))
	pass

func update_good_labels():
	$"Control/+Good Time".text = "+%s ms"%good_timing
	$"Control/-Good Time".text = "-%s ms"%good_timing
	var y_pos = range_lerp(good_timing,-timing_window,timing_window,-height/2.0,height/2.0)
	update_label("Good Time", Vector2(-width/2.0-label_margin, y_pos))
	pass


func update_bad_labels():
	$"Control/+Bad Time".text = "+%s ms"%bad_timing
	$"Control/-Bad Time".text = "-%s ms"%bad_timing
	var y_pos = range_lerp(bad_timing,-timing_window,timing_window,-height/2.0,height/2.0)
	update_label("Bad Time", Vector2(-width/2.0-label_margin, y_pos))
	pass

func update_window_labels():
	$"Control/+Window Time".text = "+%s ms"%timing_window
	$"Control/-Window Time".text = "-%s ms"%timing_window
	var y_pos = range_lerp(timing_window,-timing_window,timing_window,-height/2.0,height/2.0)
	update_label("Window Time", Vector2(-width/2.0-label_margin, y_pos))
	pass

func update_labels():
	update_window_labels()
	update_bad_labels()
	update_good_labels()
	update_sick_labels()
	update_max_labels()
	pass



# Called when the node enters the scene tree for the first time.
func _ready():
	update_labels()
	$Line2D2.position.y = range_lerp(max_timing, - timing_window, timing_window, height/2.0, -height/2.0)
	print("this")
	hits.sort_custom(hit_sorter, "sort_hits")
	pass # Replace with function body.

func _draw():
	if hits != []:
		var points = hits
		var end_time = points[-1][0]
		for point in points:
			var pos_y = range_lerp(clamp(point[1],-timing_window,timing_window),-timing_window,timing_window,height/2.0,-height/2.0)
			var pos_x = range_lerp(point[0],0,end_time,-width/2.0,width/2.0)
			var col = Color(1,0,0)
			if abs(point[1]) < max_timing:
				col = Color(0,1,1)
			elif abs(point[1]) < sick_timing:
				col = Color(1,1,1)
			elif abs(point[1]) < good_timing:
				col = Color(0,1,0)
			
			draw_circle(Vector2(pos_x,pos_y),point_size, col)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
