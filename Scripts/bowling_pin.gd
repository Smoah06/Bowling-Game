extends RigidBody3D

@onready var pin_hit = $PinHit

func _on_body_entered(body):
	var rand = randi_range(1,2)
	if body.name != "Lane":
		if rand == 1:
			pin_hit.pitch_scale = randf_range(0.8,1.2)
			pin_hit.play()
