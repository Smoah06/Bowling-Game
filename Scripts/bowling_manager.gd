extends Node3D

signal start_frame

@onready var ball_controls = $"../BallControls"
@onready var pins = $"../pins"
@onready var score_board = $"../UI/ScoreBoard"
@onready var result = $"../Camera3D/Result"

var remaining_pins
var resetted = true

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.1).timeout
	_start_frame()

func _start_frame():
	ball_controls._reset_stuff()
	if FrameAndRoll.frame == 3:
		pins._set_pins([false, true, true, true, true, true, true, true, true, true])
	elif FrameAndRoll.frame == 6:
		pins._set_pins([false, false, false, false, false, false, false, false, false, false])
	elif FrameAndRoll.frame == 10:
		pins._set_pins([false, false, false, false, false, true, false, false, true, false])
	else:
		pins._set_pins([true, true, true, true, true, true, true, true, true, true])
	resetted = true
	emit_signal("start_frame")
func _continue_frame(remaining_pins):
	ball_controls._reset_stuff()
	if FrameAndRoll.frame == 10:
		pins._set_pins([false, false, false, false, false, true, false, false, true, false])
	else:
		pins._set_pins(remaining_pins)
	resetted = true
	

func _end_roll():
	remaining_pins = pins._check_pins()
	print(remaining_pins)
	var points = 0
	for pin in remaining_pins:
		if pin == false:
			points += 1
	Points.score[FrameAndRoll.frame - 1][FrameAndRoll.roll - 1] = points
	Points._calc_score()
	score_board._update_score_board()
	
	result._activate(points)
	await get_tree().create_timer(3).timeout
	result._reset()
	FrameAndRoll.roll += 1
	
	pins._remove_pins()
	
	if FrameAndRoll.frame == 3:
		remaining_pins[0] = false
	elif FrameAndRoll.frame == 6:
		remaining_pins == [false, false, false, false, false, false, false, false, false, false]
	if points == 10:
		FrameAndRoll.frame += 1
		FrameAndRoll.roll = 1
		_start_frame()
	else:
		_continue_frame(remaining_pins)
func _end_frame():
	remaining_pins = pins._check_pins()
	print(remaining_pins)
	var points = 0
	for pin in remaining_pins:
		if pin == false:
			points += 1
	Points.score[FrameAndRoll.frame - 1][FrameAndRoll.roll - 1] = points
	Points._calc_score()
	score_board._update_score_board()
	FrameAndRoll.frame += 1
	
	result._activate(points)
	await get_tree().create_timer(3).timeout
	result._reset()
	
	FrameAndRoll.roll = 1
	if FrameAndRoll.frame == 11:
		get_tree().change_scene_to_file("res://Assets/Scenes/results_screen.tscn")
	else:
		pins._remove_pins()
		_start_frame()

func _process(delta):
	if ball_controls.ball_instance != null:
		if ball_controls.ball_instance.timer > 10 and not resetted:
			resetted = false
			ball_controls.ball_instance.can_change_gravity = false
			if FrameAndRoll.roll == 2:
				_end_frame()
			else:
				_end_roll()
func _on_pin_area_body_entered(body):
	ball_controls.ball_instance.can_change_gravity = false
	await get_tree().create_timer(4).timeout
	if FrameAndRoll.roll == 2:
		_end_frame()
	else:
		_end_roll()
