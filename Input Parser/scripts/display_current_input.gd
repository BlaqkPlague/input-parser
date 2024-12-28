
extends PanelContainer

enum ControlType {
	LSTICK, 
	LURDL, 
	RSTICK, 
	RNESW,
}
enum Panels {
	LEFT_ARROW, 
	LEFT_ANGLE, 
	RIGHT_ANGLE, 
	RIGHT_ARROW,
}
const ARROW_LOOKUP := ["⭘", "↑", "↗", "→", "↘", " ↓ ", "↙", "←", "↖"]

var curr_angles: Array[int] = [0, 0, 0, 0]

@onready var display_labels = $Divider.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.inputs_changed.connect(_on_inputs_changed)


func _on_inputs_changed(control_type, curr_angle, _timestamp):
	#prints(control_type, curr_angle, _timestamp)
	curr_angles[control_type] = curr_angle
	
	var display_angles: Vector2i = Vector2i.ZERO
	display_angles.x = (curr_angles[0] + curr_angles[1] - 1) % 8 + 1
	display_angles.y = (curr_angles[2] + curr_angles[3] - 1) % 8 + 1
	
	display_labels[Panels.LEFT_ARROW].text = str(ARROW_LOOKUP[display_angles.x])
	display_labels[Panels.LEFT_ANGLE].text = str(display_angles.x)
	display_labels[Panels.RIGHT_ANGLE].text = str(display_angles.y)
	display_labels[Panels.RIGHT_ARROW].text = str(ARROW_LOOKUP[display_angles.y])
