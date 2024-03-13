extends Control

@onready var score = $Score
@onready var total_score = $TotalScore
@onready var final_score = $FinalScore

var scores
var total_scores

func _ready():
	scores = score.get_children()
	total_scores = total_score.get_children()

func _update_score_board():
	
	var i = 0
	var j = 0
	for _score in scores:
		if Points.score[i][0] + Points.score[i][1] == 10 and j == 1:
			_score.text = "/"
		elif Points.score[i][j] == 10:
			_score.text = "X"
		else:
			_score.text = str(Points.score[i][j])
		j += 1
		if j == 2:
			j = 0
			i += 1
		if i == 10:
			i = 9
			j = 2
	i = 0
	for _total_score in total_scores:
		_total_score.text = str(Points.total_score[i])
		i += 1
		
	final_score.text = str(Points.final_score)
