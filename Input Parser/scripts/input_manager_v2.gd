@icon("res://assets/game-controller-outline.svg")
class_name InputManagerV2
extends Node

## Outputs 8-way angle of controller regions. 
##
## Reads inputs from Left Stick, D-Pad, Right Stick, and Face Buttons. 
## Then, outputs angle as signals to be handled by daughter / other nodes.

enum ControlType {
	LSTICK, 
	LURDL, 
	RSTICK, 
	RNESW,
}
enum Direction {
	UP, 
	RIGHT, 
	DOWN, 
	LEFT,
}

const INPUT := [
	[
		"p1_leftstick_up",
		"p1_leftstick_right",
		"p1_leftstick_down",
		"p1_leftstick_left",
	], [
		"p1_dpad_up",
		"p1_dpad_right",
		"p1_dpad_down",
		"p1_dpad_left",
	], [
		"p1_rightstick_north",
		"p1_rightstick_east",
		"p1_rightstick_south",
		"p1_rightstick_west",
	], [
		"p1_nesw_north",
		"p1_nesw_east",
		"p1_nesw_south",
		"p1_nesw_west",
	]
]
const ANGLE_LOOKUP := [
	[8,1,2],
	[7,0,3],
	[6,5,4],
]
const ARROW_LOOKUP := ["⭘", "↑", "↗", "→", "↘", " ↓ ", "↙", "←", "↖"]
const CONTROL_STRINGS: Array[String] = ["LSTICK", "LURDL", "RSTICK", "RNESW"]

var prev_vectors: Array[Vector2] = [Vector2.ZERO, Vector2.ZERO, Vector2.ZERO, Vector2.ZERO]
var prev_angles: Array[int] = [0, 0, 0, 0]


func _ready():
	prints(Time.get_ticks_msec(), "Input Manager v2 Ready")
	pass # Replace with function body.

func _input(_event):
	for control_type in 4:
		# Lookup and broadcast input as clockwise 8-way angle. 0 = idle.
		## Inputs x & y are intentionally separated to increase the angle of orthaganal directions on analog sticks. This allows cleaner gestures.
		var curr_vector: Vector2
		curr_vector.x =  int(Input.is_action_pressed(INPUT[control_type][Direction.RIGHT])) - int(Input.is_action_pressed(INPUT[control_type][Direction.LEFT]))
		curr_vector.y =  int(Input.is_action_pressed(INPUT[control_type][Direction.DOWN])) - int(Input.is_action_pressed(INPUT[control_type][Direction.UP]))
		
		if curr_vector != prev_vectors[control_type]:
			var curr_angle: int = ANGLE_LOOKUP[curr_vector.y+1][curr_vector.x+1]
			
			prev_angles[control_type] = curr_angle
			prev_vectors[control_type] = curr_vector
			
			#prints(control_type, curr_angle, Time.get_ticks_msec())
			SignalBus.inputs_changed.emit(control_type, curr_angle, Time.get_ticks_msec())
