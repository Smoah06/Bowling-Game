extends RigidBody3D

var gravity_direction = Vector3.DOWN
var gravity_mag = 9.8
var gravity_time = 0

var speed = 10
var direction = Vector3(0,0,1)
var is_moving = true
var can_change_gravity = true

var timer = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer + delta
	if is_moving:
		var ray = _check_ground()
		if ray[1] != null and can_change_gravity:
			gravity_direction = -ray[1]
		if ray[0] == null or (ray[0] - position).length() > 0.2:
			gravity_time += 1
		else:
			gravity_time = 1
		print(direction)
		if FrameAndRoll.frame == 4:
			linear_velocity = gravity_direction * (gravity_mag * delta * gravity_time) + gravity_direction.rotated(Vector3(-1,0,0), PI/2).rotated(Vector3(0,1,0), direction) * speed + gravity_direction.rotated(Vector3(-1,0,0), PI/2).rotated(Vector3(0,1,0), 90) * speed/5
		else:
			linear_velocity = gravity_direction * (gravity_mag * delta * gravity_time) + gravity_direction.rotated(Vector3(-1,0,0), PI/2).rotated(Vector3(0,1,0), direction) * speed
func _check_ground():
	var ray = $RayCast3D
	if ray.is_colliding():
		return [ray.get_collision_point(), ray.get_collision_normal()]
	else:
		return [null,null]

