extends Camera2D
class_name GameCam

var draggable : bool = false
var dragging : bool = false

var click_pos : Vector2 = Vector2.ZERO
var cam_speed : float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if not draggable: return
	
	if event.is_action_pressed("right_click"):
		dragging = true
	elif event is InputEventMouseMotion and dragging:
		position -= event.relative * cam_speed
	if event.is_action_released("right_click"):
		dragging = false
	
func toggle_draggable(toggle : bool) -> void:
	draggable = toggle
	
	if not draggable:
		global_position = Vector2.ZERO
