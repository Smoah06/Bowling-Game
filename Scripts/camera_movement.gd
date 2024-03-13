extends Camera3D

@onready var ball_controls = $"../BallControls"
@onready var camera_angle_1 = $"../CameraAngle1"
@onready var camera_angle_2 = $"../CameraAngle2"

var touched_area

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ball_controls.state == "start":
		position = camera_angle_2.position
		rotation = camera_angle_2.rotation
	elif ball_controls.state == "done":
		if !touched_area:
			position = lerp(position, ball_controls.ball_instance.position + Vector3(0.25,0.25,-1), 0.8)
			rotation_degrees = Vector3(0, 180, 0)
		else:
			position = camera_angle_1.position
			rotation = camera_angle_1.rotation
	else:
		position = lerp(position, ball_controls.placeholder_ball.position + Vector3(0.25,0.25,-1), 0.8)
		rotation_degrees = Vector3(-20, 180, 0)
		touched_area = false
func _on_pin_area_body_entered(body):
	touched_area = true
