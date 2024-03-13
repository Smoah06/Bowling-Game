extends Control

@onready var text = $Text
var direction = -1

func _process(delta):
	text.modulate.a += direction * delta
	if text.modulate.a < 0 or text.modulate.a > 1:
		direction *= -1
