extends Node


# Declare variables.
@export var max_double_tap_time :float = 0.25
@export var max_dropped_input_time :float = 0.125
@export var acceleration = 0.5
@export var max_acceleration = 2.0
@export var jolt = 0.5
@export var max_jolt = 1.0
@export var decay :float = 16

var current_time = Time.get_ticks_msec()
var roll_duration = Time.get_ticks_msec()
var test_time = 0

var curr_input = null
var prev_input = null
var dropped_input_timer = 0.0
var double_tap_timers = []
var mouse_click_on = false
var target_position = Vector2.ZERO

func converge_position (current_pos, target_pos, decay_amount, delta):
	return target_pos  + (current_pos - target_pos) * exp(-decay_amount * delta)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get screen height & width.
	# Determine if width exceeds a single screen.
	# Determine if square ratio is acceptable.
	# Determine points for JumpNodes.

	prints ("Holden Tapp's Mouse online", Time.get_ticks_msec())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
		
	# Case 0 (Null Input)
	if max_dropped_input_time - current_time < max_dropped_input_time :
# 		Countdown DroppedInputTimer
# 		CurrInput = PrevInput
		pass
# 	Else
 		#Func ConvergePosition (Target.Position)
		#converge_position(%mouse.position, %target.position, decay, delta)
# 

# Case 1 (Single Input)
# 	If DroppedInputTimer Active
# 		Countdown DroppedInputTimer
# 		CurrInput = PrevInput
# 	Else
# 		Highlight JumpNode region
# 

# Case 2 (Second Input)
# 	If RollDuration < DoubleTapTimer
# 		If Double Down 
# 			Mouse Click On
# 		Else	
# 			If DoubleTapTimers Active
# 				Activate Tab
# 				Set TargetPosition from JumpNodeLookup Table
# 				Acceleration = MaxAcceleration
# 				Jolt = MaxJolt (Needed)
# 			Else
# 				Push Time to DoubleTapTimers
# 	Else
#	 	DroppedInputTimer = Reset to 0.25 sec
	max_dropped_input_time = Time.get_ticks_msec()
#	
# 	Increase RollDuration
# 

# ## From All Cases
# ConvergePosition (Mouse.Position, Target.Position)
# 

# func converge_position (movable_position, target_position)
# 	If PrevInput = CurrInput
# 		Converge Jolt to MinJolt
# 		Converge Acceleration to MinAcceleration
# 	Else
# 		Calculate AngleDifferences
# 		Converge Jolt to MaxJolt
# 		Converge Acceleration to MaxAcceleration
# 	Converge Movable.Position to Target.Position
# 

# DroppedInputTimer Expired
# 	Mouse Click Off
# 	RollDuration = Reset to 0.0 sec
# 	Acceleration = Reset to .50 %
# 	Jolt = Reset to .50 %
# 

	pass
	
