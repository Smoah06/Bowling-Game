extends Node3D

@onready var pivot = $Pivot
@onready var final_score = $UI/FinalScore
@onready var score_board = $UI/ScoreBoard

# Called when the node enters the scene tree for the first time.
func _ready():
	final_score.text = str(Points.final_score)
	score_board._update_score_board()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pivot.rotation_degrees.y += 1 * delta * 30
	if Input.is_action_just_pressed("submit"):
		get_tree().change_scene_to_file("res://Assets/Scenes/main_menu.tscn")
