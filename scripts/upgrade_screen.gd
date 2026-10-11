extends Node2D
class_name UpgradesScreen

var active : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if not active: return
	
	if event.is_action_pressed("select"):
		if owner.hover_objs.size() == 0: return
		
		owner.hover_objs[0].emit_signal("clicked")

func toggle_active(toggle : bool) -> void:
	active = toggle
	
	visible = active
	for up in get_children():
		up.get_node("Area2D/CollisionShape2D").disabled = !active
