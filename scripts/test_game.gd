extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var hud: HUD = $HUD
@onready var game_screen: GameScreen = $GameScreen
@onready var upgrade_screen: UpgradesScreen = $UpgradesScreen
@onready var market_screen: Node2D = $MarketScreen

var clicked_obj : Node2D = null
var hover_objs : Array = []

func _ready() -> void:
	_on_game_screen_pressed()

func _process(_delta: float) -> void:
	hover_objs = get_objects_mouse_hover()

func get_objects_mouse_hover() -> Array:
	var mouse_pos = get_global_mouse_position()
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	query.collide_with_areas = true
	query.collide_with_bodies = true
	
	var results = space_state.intersect_point(query)
	#print(results)
	var objects = []
	for result in results:
		objects.append(result.collider.owner)
	
	var object_owners = []
	for obj in objects:
		if obj is SlotHitboxTest:
			#print(obj)
			object_owners.append(obj.parent)
		else:
			object_owners.append(obj)
	
	return object_owners

func _on_upgrades_screen_pressed() -> void:
	print("upgrades")
	game_screen.toggle_active(false)
	upgrade_screen.toggle_active(true)
	market_screen.toggle_active(false)


func _on_game_screen_pressed() -> void:
	print("game screen")
	game_screen.toggle_active(true)
	upgrade_screen.toggle_active(false)
	market_screen.toggle_active(false)


func _on_market_screen_pressed() -> void:
	print("market")
	game_screen.toggle_active(false)
	upgrade_screen.toggle_active(false)
	market_screen.toggle_active(true)
