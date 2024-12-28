
@icon("res://assets/computer-mouse-svgrepo-com.svg")
class_name HoldenTappsMouse
extends Node

@onready var reticle = %InputReticle
@onready var cursor = %Cursor
@onready var screen_size = get_viewport().size
@export var speed_scaler :float = 10.0
@export var rotation_scaler :float = PI / 8
@export var cursor_decay :float = 5 #Effective values: 1 to 20.
@export var reticle_decay :float = 20 #Effective values: 1 to 20.

var all_angles: Array[int] = [0, 0, 0, 0]
var curr_angles: Vector2i = Vector2i.ZERO

func _ready():
	SignalBus.inputs_changed.connect(_on_inputs_changed)
	SignalBus.rotation_changed.connect(_on_rotation_changed)

func decay_function(curr_value, target_value, decay_ammount, delta_time):
	return target_value + (curr_value - target_value) * exp(-decay_ammount * delta_time)

func _on_visible_on_screen_notifier_2d_screen_exited():
	reticle.position.x = fposmod(reticle.position.x, screen_size.x)
	reticle.position.y = fposmod(reticle.position.y, screen_size.y)

func _on_inputs_changed(control_type, new_angle, _timestamp):
	all_angles[control_type] = new_angle
	curr_angles.x = (all_angles[0] + all_angles[1] - 1) % 8 + 1
	curr_angles.y = (all_angles[2] + all_angles[3] - 1) % 8 + 1

func _on_rotation_changed(control_type, new_rotation, _timestamp):
	var curr_rotations: Vector2i = Vector2i.ZERO
	if control_type < 2:
		curr_rotations.x = new_rotation
	else:
		curr_rotations.y = new_rotation
	
	if curr_angles.x and curr_angles.y:
		reticle.position.x += ((curr_rotations.x + curr_rotations.y) * speed_scaler)
		reticle.position.y += ((curr_rotations.x - curr_rotations.y) * speed_scaler)
		reticle.rotation += (curr_rotations.x + curr_rotations.y) * rotation_scaler

func _process(delta):
	cursor.position.x = decay_function(cursor.position.x, reticle.position.x, cursor_decay, delta)
	cursor.position.y = decay_function(cursor.position.y, reticle.position.y, cursor_decay, delta)
	
	if not (curr_angles.x or curr_angles.y):
		reticle.position.x = decay_function(reticle.position.x, cursor.position.x, reticle_decay, delta)
		reticle.position.y = decay_function(reticle.position.y, cursor.position.y, reticle_decay, delta)
