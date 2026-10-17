extends Node2D
class_name MarketScreen

var active : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func toggle_active(toggle : bool) -> void:
	active = toggle
	
	visible = active
	
	for item : MarketItem in get_children():
		item.get_node("ActionButton").disabled = !active
