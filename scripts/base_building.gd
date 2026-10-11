extends Node2D
class_name BaseBuilding

@onready var resource_generator: ResourceGenerator = $ResourceGenerator
@onready var build_piece_test: BuildPieceTest = $BuildPieceTest

var resources : Array[Array] = []
var shape : Array[Array] = []
var built : bool = false

var upgrades : Array[BaseUpgrade] = []

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
	if active: resource_generator.do_work(power)
	#print("Work work!")

func toggle_active(toggle : bool) -> void:
	active = toggle
	
	build_piece_test.toggle_active(active)
	if built: resource_generator.emit_signal("generating", active)

func set_resource_and_shape() -> void:
	pass
