extends Node3D
@onready var bumps = $"../Bumps"
@onready var music = $"../Music"
@onready var music_2 = $"../Music2"
@onready var gormless_2 = $"../The Gorms/Gormless2"
@onready var gormless = $"../The Gorms/Gormless"

func _on_bowling_manager_start_frame():
	if FrameAndRoll.frame == 6:
		music.stop()
		music_2.play()
	elif FrameAndRoll.frame == 7:
		bumps.visible = true
		for bump in bumps.get_children():
			bump.get_child(1).disabled = false
		
	elif FrameAndRoll.frame == 8:
		bumps.visible = false
		for bump in bumps.get_children():
			bump.get_child(1).disabled = true
		gormless_2.visible = true
	elif FrameAndRoll.frame == 9:
		music_2.stop()
		gormless_2.visible = false
	elif FrameAndRoll.frame == 10:
		gormless.visible = true
