extends Node2D
class_name BaseBuilding

@onready var resource_generator: ResourceGenerator = $ResourceGenerator
@onready var build_piece_test: BuildPieceTest = $BuildPieceTest

@export var build_cost_res : Array[String] = []
@export var build_cost_amt : Array[int] = []

var resources : Array[Array] = []
var shape : Array[Array] = []
var built : bool = false

var active : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_resource_and_shape()
	
	resource_generator.emit_signal("change_resources", resources)
	build_piece_test.make_shape(shape)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func toggle_generator(toggle : bool) -> void:
	resource_generator.emit_signal("generating", toggle)

func work_click(power : float = 0.0) -> void:
	#power = % bonus (0.2 = 20% increase = 1.2 in total)
	if active and built: resource_generator.do_work(power)
	#print("Work work!")

func toggle_active(toggle : bool, build_mode : bool) -> void:
	active = toggle
	
	if not active: build_piece_test.toggle_active(build_mode)
	else: build_piece_test.toggle_active(active)
	if active and not build_mode: toggle_generator(true)
	else: toggle_generator(false)

func set_resource_and_shape() -> void:
	pass

func remove_building() -> void:
	for c in range(0, build_cost_res.size()):
		ResourcesHolder.resources_held[build_cost_res[c]] += build_cost_amt[c]
	
	get_tree().get_first_node_in_group("GameScreen").unbuilt_buildings.erase(self)
	queue_free()

func toggle_built(toggle : bool) -> void:
	built = toggle
	
	toggle_generator(built)
	if built: get_tree().get_first_node_in_group("GameScreen").unbuilt_buildings.erase(self)
	elif not built and not get_tree().get_first_node_in_group("GameScreen").unbuilt_buildings.has(self): get_tree().get_first_node_in_group("GameScreen").unbuilt_buildings.append(self)
	
	
