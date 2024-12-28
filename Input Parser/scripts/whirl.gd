
extends Node

## Broadcasts the change of angle of an 8-way directional input.
## 
## Accepts inputs_changed signal and broadcasts if 8-way direction changes angle, 
## and by how much. This allows for skipped inputs to be interpreted and handled. 
## if 180 rotation occurs in a single frame, it will duplicate and re-broadcast 
## the previous movement.

var prev_rotations: Array[int] = [0, 0, 0, 0]
var prev_angles: Array[int] = [0, 0, 0, 0]

func _ready():
	prints(Time.get_ticks_msec(), "Whirl Ready.")
	SignalBus.inputs_changed.connect(_on_inputs_changed)

func compare_angles(new_angle, prev_angle, prev_rotation):
	if prev_angle * new_angle == 0: 
		return 0 #nullifies start/stop
	var curr_rotation: int = (new_angle - prev_angle + 12) % 8 -4
	if curr_rotation == -4: # checks for 180 rotation
		return prev_rotation
	return curr_rotation
	
func _on_inputs_changed(control_type, new_angle, _timestamp):
	var curr_rotation: int = compare_angles(new_angle, prev_angles[control_type], prev_rotations[control_type])
	prev_angles[control_type] = new_angle
	prev_rotations[control_type] = curr_rotation
	
	SignalBus.rotation_changed.emit(control_type, curr_rotation, Time.get_ticks_msec())
	#prints(control_type, curr_rotation, Time.get_ticks_msec())
