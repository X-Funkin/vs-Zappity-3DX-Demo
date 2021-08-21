extends Node2D

export(NodePath) var combo_count_label
export(NodePath) var max_count_label
export(NodePath) var sick_count_label
export(NodePath) var good_count_label
export(NodePath) var bad_count_label
export(NodePath) var miss_count_label

var hits = []
var judgments = {"Maxes": 0, "Sicks": 0, "Goods": 0, "Bads": 0, "Misses": 0}
var max_combo = 0
var total_notes = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func recieve_player_note_count(note_count):
	total_notes = note_count
	pass

func recieve_player_hit(note, hit_error):
	hits.append([note.hit_time,hit_error])

func recieve_player_miss(note_n):
	judgments.Misses += 1

func recieve_player_combo(combo):
	max_combo = max(max_combo, combo)

func recieve_player_judgment(judgment):
	match judgment:
		5:
			judgments.Maxes += 1
		4:
			judgments.Sicks += 1
		3:
			judgments.Goods += 1
		2:
			judgments.Bads += 1
	pass

func get_accuracy():
	var total_hits = judgments.Maxes+judgments.Sicks+judgments.Goods+judgments.Bads+judgments.Misses
	var total_points = judgments.Maxes*300+judgments.Sicks*300+judgments.Goods*200+judgments.Bads*100
	return total_points/(total_hits*300.0)

func update_judgment_labels():
	get_node(max_count_label).text = "%sx"%judgments.Maxes
	get_node(sick_count_label).text = "%sx"%judgments.Sicks
	get_node(good_count_label).text = "%sx"%judgments.Goods
	get_node(bad_count_label).text = "%sx"%judgments.Bads
	get_node(miss_count_label).text = "%sx"%judgments.Misses

func update_combo_label():
	get_node(combo_count_label).text = "%sx"%max_combo

func update_accuracy_graph():
	$"Accuracy Gragh".hits = hits
	$"Accuracy Gragh".sort_hits()
	$"Accuracy Gragh".update()

func update_accuracy_label():
	var acc = get_accuracy()
	var text = "Accuracy: %4.2f"%(acc*100.0)
	$"Accuracy Gragh/Accuracy Label".text = text+"%"
	pass

func update_rank():
	var acc = get_accuracy()
	for node in $Ranks.get_children():
		node.visible = false
	if acc == 1.0:
		$Ranks/MAX.visible = true
	elif acc < 1.0 and acc >= 0.95:
		$"Ranks/Super Sick!".visible = true
	elif acc < 0.95 and acc >= 0.90:
		$"Ranks/Sick!".visible = true
	elif acc < 0.90 and acc >= 0.80:
		$"Ranks/Good!".visible = true
	elif acc < 0.8 and acc >= 0.70:
		$"Ranks/Bad".visible = true
	elif acc < 0.7:
		$Ranks/MIN.visible = true
	pass

func show():
	update_judgment_labels()
	update_combo_label()
	update_accuracy_graph()
	update_accuracy_label()
	update_rank()
	pass


var accepting_input = false
func recieve_song_finished():
	show()
	if judgments.Misses == 0:
		get_tree().call_group("Player Hit Recievers", "recieve_player_full_combo", max_combo)
	accepting_input = true

func recieve_player_input(event):
	if accepting_input:
		if event.is_action_pressed("restart"):
			get_tree().reload_current_scene()
		if event.is_action_pressed("ui_accept"):
			get_tree().change_scene("res://assets/scenes/Menu Screens.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
export(float) var hue_shift = 1
var hue = 0.0
func _process(delta):
	var col = Color(1,0,0)
	col.h = hue
	$Ranks/MAX.modulate = col
	hue = fmod(hue+hue_shift*delta,1.0)
#	pass
