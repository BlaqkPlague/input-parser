extends PanelContainer

const ARROW_LOOKUP := ["⭘", "↑", "↗", "→", "↘", " ↓ ", "↙", "←", "↖"]

@onready var display_labels = $Divider.get_children()
enum {LEFT_ARROW, LEFT_ANGLE, RIGHT_ANGLE, RIGHT_ARROW}

#var left_angle: int = 0
#var right_angle: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.inputs_changed.connect(_on_inputs_changed)
	print(display_labels)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_inputs_changed(left_angle, right_angle):
	
	display_labels[LEFT_ARROW].text = str(ARROW_LOOKUP[left_angle])
	display_labels[LEFT_ANGLE].text = str(left_angle)
	display_labels[RIGHT_ANGLE].text = str(right_angle)
	display_labels[RIGHT_ARROW].text = str(ARROW_LOOKUP[right_angle])
