extends Node

var score = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0,0]]
var total_score = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var final_score = 0
func _calc_score():
	var i = len(score) - 2
	final_score = 0
	while i >= 0:
		if score[i][0] == 10:
			total_score[i] = score[i][0] + score[i][1] + score[i + 1][0] + score[i + 1][1]
		elif (score[i][0] + score[i][1]) == 10:
			total_score[i] = score[i][0] + score[i][1] + score[i + 1][0]
		else:
			total_score[i] = score[i][0] + score[i][1]
			
		final_score += total_score[i]
		i -= 1
