extends Node2D
class_name GameScreen

@onready var hitbox_layer: TileMapLayer = $Tilemaps/HitboxLayer

var active : bool = true

var clicked_obj : Node2D = null
var hover_objs : Array = []

var build_mode : bool = true

const origin_tile_pos : Vector2 = Vector2(408, 216)
var playable_area : Vector2 = Vector2(12,10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	
	for hb : TestTilesetScene in hitbox_layer.get_children():
		if hb.position.x < origin_tile_pos.x - (playable_area[0] * 8): 
			hb.toggle_tile_active(false)
			continue
		if hb.position.x >= origin_tile_pos.x + (playable_area[0] * 8): 
			hb.toggle_tile_active(false)
			continue
		if hb.position.y >= origin_tile_pos.y + (playable_area[1] * 16): 
			hb.toggle_tile_active(false)
			continue
		hb.toggle_tile_active(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not active: return
	
	hover_objs = get_objects_mouse_hover()
	if clicked_obj != null:
		clicked_obj.global_position = get_global_mouse_position()
		if clicked_obj is BuildPieceTest:
			clicked_obj.hovering()

func _input(event: InputEvent) -> void:
	if not active: return
	
	if event.is_action_pressed("select") and build_mode:
		for obj in hover_objs:
			#print(obj)
			if obj == clicked_obj:
				clicked_obj = null
				break
			if obj is BuildPieceTest:
				clicked_obj = obj
				break
	if event.is_action_released("select") and clicked_obj != null:
		if clicked_obj is BuildPieceTest: clicked_obj.slot()
		clicked_obj = null
	
	if event.is_action_pressed("rotate_building") and build_mode:
		if clicked_obj == null: pass
		if clicked_obj is not BuildPieceTest: pass
		clicked_obj.owner.rotation += PI/2
		while clicked_obj.owner.rotation >= 2 * PI:
			clicked_obj.owner.rotation -= 2 * PI
	
	if event.is_action_pressed("select") and not build_mode:
		for obj in hover_objs:
			if obj is BuildPieceTest: obj.owner.work_click(2.0)
	
	if event.is_action_pressed("toggle_build"):
		toggle_build_mode(!build_mode)

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

func toggle_build_mode(toggle: bool):
	build_mode = toggle
	print("Build Mode: " + str(build_mode))
	
	for building in get_node("Buildings").get_children():
		if building.built: building.toggle_generator(!build_mode)

func toggle_active(toggle : bool) -> void:
	active = toggle
	
	visible = active
	
	for build : BaseBuilding in get_node("Buildings").get_children():
			build.toggle_active(active)
