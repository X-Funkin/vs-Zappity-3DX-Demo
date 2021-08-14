extends Node2D
#class_name Note

export(int) var note_type #setget set_note_type, get_note_type
export(float) var hit_time
export(bool) var hold_note = false setget set_hold_note, get_hold_note
export(float) var hold_time setget set_hold_time, get_hold_time
export(bool) var live
export(bool) var player_note
export(float) var hit_window = 120.0
#export(PackedScene) var note_hold
export(PackedScene) onready var note_hold


#var note_name : String = "Left"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = true
var enemy_hit = false
var playing_hold = false
var scorable = false
# Called when the node enters the scene tree for the first time.

#func set_note_type(n_type):
#	note_type = n_type
#	match note_type:
#		0:
#			note_name = "Left"
#		1:
#			note_name = "Down"
#		2:
#			note_name = "Up"
#		3:
#			note_name = "Right"
#
#func get_note_type():
#	return note_type

func set_hold_note(is_hold):
	if is_hold != hold_note:
		hold_note = is_hold
		if is_hold:
			if $"Note Hold" != null:
				$"Note Hold".visible = true
				return 1
			print("\n\neyahf;alkjsdhfl;kjsa yeah fuosagdhfiokjsahg")
#			print(self.print_tree())
#			print_tree()
#			print(name)
#			print(note_hold)
#			print(note_hold.name)
#			var hold_inst = note_hold.instance()
#
#			add_child(hold_inst)
			return 1
		$"Note Hold".visible = false

func get_hold_note():
	return hold_note

func set_hold_time(n_time):
	hold_time = n_time
	if hold_note and $"Note Hold" != null:
		$"Note Hold".hold_time = n_time


func get_hold_time():
	return hold_time

func scale_set(n_scale):
#	print("SACALLINNNNG BRTUHHS ")
	$"Note Hold".scale_set(1.0/n_scale)
	#scale.y = n_scale
	
#	$"Down Note Hold Transform".scale.y = 1.0/scale.y
#	$"Down Note Hold Transform/Down Note Hold/Down Note Hold End".global_scale.y = 1
func _ready():
#	scale = scale
#	scale_set(scale.y)
	$"Note Hold".played_time = -hit_time
	$"Note Hold".hold_time = hold_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
var ughghihgg = false

func _process(delta):
	if !ughghihgg:
		ughghihgg = true
		$"Note Hold".played_time = -hit_time
		$"Note Hold".hold_time = hold_time
	if live and !player_note:
		if hold_note:
			if (-get_parent().position.y >= hit_time) and (-get_parent().position.y < hit_time+hold_time) and active:
#				visible = true
				$"Note Hold".hold_time = hold_time
				get_parent().get_parent().get_parent().play_hit()
				position.y = -get_parent().position.y
#				global_position.y = 0.0
				$"Note Hold".played_time = -get_parent().position.y-hit_time
				if !playing_hold:
					add_to_group("Song Time Recievers")
				playing_hold = true
				return 0
			if (-get_parent().position.y >= hit_time+hold_time) and active:
				visible = false
				position.y = -get_parent().position.y
				$"Note Hold".played_time = 0.0
				active = false
				playing_hold = false
				remove_from_group("Song Time Recievers")
				return 0
			if (-get_parent().position.y <= hit_time+hold_time) and !active:
				active = true
				visible = true
				playing_hold = false
				$"Note Hold".played_time = -hit_time
				$"Note Hold".hold_time = hold_time
#				$"Note Hold".played_time = -get_parent().position.y-hit_time
				position.y = hit_time
				return 0
		if -get_parent().position.y > hit_time and active:
			visible = false
			get_parent().get_parent().get_parent().play_hit()
			active = false
			return 0
		if -get_parent().position.y <= hit_time and !active:
			active = true
			visible = true
			return 0
		return 0
	if live and active:
		if -get_parent().position.y >= hit_time-hit_window and !scorable:
#			if !scorable:
			scorable = true
			add_to_score_group()
			return 0
		if -get_parent().position.y < hit_time-hit_window and scorable:
#			if scorable:
			scorable = false
			remove_from_score_group()
			return 0
		if -get_parent().position.y > hit_time+hit_window:
			print("iojafyiopauhfldksajghfdlkjsaghflksahflkjdsaf UUGUHA\n\nalksfjsaf\n\nfnalsdfkjas")
			despawn()
			return 0
		return 0
	if live and !active:
		if -get_parent().position.y < hit_time-hit_window:
			spawn()
#			active = false
#			if scorable:
#				remove_from_score_group()
#			scorable = false
#			visible = false
#			despawn()
	
#			despawn()
			#	pass

func despawn():
	active = false
	if scorable:
		remove_from_score_group()
	scorable = false
	visible = false

func spawn():
	active = true
	visible = true
	remove_from_score_group()
	scorable = false
func add_to_score_group():
	add_to_group("Scorable Notes")
	match note_type:
		0:
			add_to_group("Left Scorable Notes")
		1:
			add_to_group("Down Scorable Notes")
		2:
			add_to_group("Up Scorable Notes")
		3:
			add_to_group("Right Scorable Notes")

func remove_from_score_group():
	remove_from_group("Scorable Notes")
	match note_type:
		0:
			remove_from_group("Left Scorable Notes")
		1:
			remove_from_group("Down Scorable Notes")
		2:
			remove_from_group("Up Scorable Notes")
		3:
			remove_from_group("Right Scorable Notes")


func recieve_songtime(s_time):
	position.y = s_time
