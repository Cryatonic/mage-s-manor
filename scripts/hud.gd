extends Control
class_name HUD


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for key in ResourcesHolder.resources_held.keys():
		var t : String = ""
		
		var amt : int = int(ResourcesHolder.resources_held[key])
		var mag : int = floor(log(amt) / log(10))
		
		if mag < 4: t = str(amt)
		else: t = str(amt).substr(0,1) + "." + str(amt).substr(1,1) + "E" + str(mag)
		
		get_node(key).get_node("Amt").text = str(t)
