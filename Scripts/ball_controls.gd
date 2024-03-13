extends Node3D

var state = "move"
var speed = 0
var ball_pos
var ball_direction
var ball_spin

@onready var score_board = $"../UI/ScoreBoard"
@onready var placeholder_ball = $PlaceholderBall
@onready var arrow = $Arrow
@onready var flicker_ui = $"../UI/FlickerUI"
@onready var move_arrows = $"../UI/Move arrows"

var rotation_direction = 1
var power_direction = -1

var ball_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	placeholder_ball.position.x = 0.6
	placeholder_ball.show()
	arrow.show()

func _reset_stuff():
	state = "start"
	placeholder_ball.position.x = 0.6
	placeholder_ball.show()
	arrow.show()
	arrow.scale.z = 1
	arrow.rotation_degrees.y = 0
	if ball_instance != null:
		ball_instance.queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == "start":
		score_board.visible = true
		flicker_ui.visible = true
		move_arrows.visible = false
		if Input.is_action_just_pressed("submit"):
			state = "move"
	elif state == "move":
		score_board.visible = false
		move_arrows.visible = true
		if Input.is_action_just_pressed("submit"):
			state = "pivot"
			ball_pos = placeholder_ball.position
		arrow.position.x = placeholder_ball.position.x
		if Input.is_action_pressed("move_ball_right") and placeholder_ball.position.x > -0.6:
			placeholder_ball.position.x -= 0.1 * delta * 10
		if Input.is_action_pressed("move_ball_left")and placeholder_ball.position.x < 0.6:
			placeholder_ball.position.x += 0.1 * delta * 10
	elif state == "pivot":
		move_arrows.visible = false
		if Input.is_action_just_pressed("submit"):
			state = "power"
			ball_direction = arrow.rotation.y
		if arrow.rotation_degrees.y >= 15 or arrow.rotation_degrees.y <= -15:
			rotation_direction *= -1 
		arrow.rotation_degrees.y += 50 * delta * rotation_direction
	elif state == "power":
		if Input.is_action_just_pressed("submit"):
			state = "throw"
			speed = arrow.scale.z
		if arrow.scale.z < 0 or arrow.scale.z > 1:
			power_direction *= -1 
		arrow.scale.z += delta * power_direction
	elif state == "throw":
		flicker_ui.visible = true
		placeholder_ball.hide()
		arrow.hide()
		var ball = load("res://Assets/Scenes/bowling_ball.tscn")
		ball_instance = ball.instantiate()
		add_child(ball_instance)
		ball_instance.position = ball_pos
		ball_instance.speed = speed * 15
		ball_instance.direction = ball_direction
		if FrameAndRoll.frame == 2:
			ball_instance.mass = 0.1
		elif FrameAndRoll.frame == 3:
			ball_instance.mass = 12.7
		state = "done"
		
