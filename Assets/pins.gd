extends Node3D

@export var pins : Array[Node3D]
var pins_pos = []
var pins_rot = []
var cloned_pins
func _ready():
	cloned_pins = []
	for pin in pins:
		pin.hide()
	for pin in pins:
		pins_pos.append(pin.position)
		pins_rot.append(pin.rotation)
		
func _set_pins(selected_pins):
	var i = 0
	for pin in pins:
		pin.visible = selected_pins[i]
		pin.freeze = !selected_pins[i]
		pin.get_child(1).disabled = !selected_pins[i]
		i += 1
		
func _check_pins():
	var pins_tipped_over = []
	print("sss")
	var i = 0
	for pin in pins:
		print(pin.rotation_degrees)
		if abs(pin.rotation_degrees.x) > 20 or abs(pin.rotation_degrees.z) > 20 or pin.position.length() > 10:
			pins_tipped_over.insert(i, false)
		else:
			pins_tipped_over.insert(i, true)
	return pins_tipped_over
func _remove_pins():
	for pin in cloned_pins:
		pin.queue_free()
	# Reinitialize cloned_pins with new instances of pins
	var i = 0
	for pin in pins:
		pin.freeze = true
		pin.position = pins_pos[i]
		pin.rotation = pins_rot[i]
		if FrameAndRoll.frame != 5:
			pin.freeze = false
		i += 1
