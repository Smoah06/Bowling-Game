extends Node3D

@onready var pivot = $Pivot
@onready var animation_player = $AnimationPlayer

@onready var boo = $Boo
@onready var celebration = $Celebration
@onready var clap = $Clap
@onready var wey = $Wey


var score

var prev_num_of_pins = 0

func _activate(num_of_pins):
	if FrameAndRoll.roll == 1:
		prev_num_of_pins = 0
	if num_of_pins + prev_num_of_pins >= 10:
		if FrameAndRoll.roll == 1:
			score = pivot.get_node("X")
		elif FrameAndRoll.roll == 2:
			score = pivot.get_node("spare")
	else:
		score = pivot.get_node(str(num_of_pins))
	
	if num_of_pins == 0:
		boo.play()
	elif num_of_pins <= 5:
		wey.play()
	elif num_of_pins <= 9:
		clap.play()
	elif num_of_pins + prev_num_of_pins >= 10:
		celebration.play()
	prev_num_of_pins = num_of_pins
	score.visible = true
	animation_player.play("Active")
func _reset():
	score.visible = false
