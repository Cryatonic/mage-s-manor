extends Node2D
class_name GameScreen

@warning_ignore("unused_signal")
signal create_building(type : String, c_res : Array[String], c_amt : Array[int])
@warning_ignore("unused_signal")
signal get_building_upgrade(upgrade : BaseUpgradeStrategy)

@onready var hitbox_layer: TileMapLayer = $Tilemaps/HitboxLayer
@onready var buildings: Node2D = $Buildings
var unbuilt_buildings : Array[BaseBuilding] = []

var active : bool = true

#var clicked_obj : Node2D = null
#var hover_objs : Array = []

var build_mode : bool = true

const origin_tile_pos : Vector2 = Vector2(408, 216)
var playable_area : Vector2 = Vector2(10,10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	
	for e in buildings.get_children():
		unbuilt_buildings.append(e)
	
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
	
	#hover_objs = get_objects_mouse_hover()
	if owner.clicked_obj != null:
		owner.clicked_obj.global_position = get_global_mouse_position()
		if owner.clicked_obj is BuildPieceTest:
			owner.clicked_obj.hovering()

func _input(event: InputEvent) -> void:
	if not active: return
	
	if event.is_action_pressed("select") and build_mode:
		for obj in owner.hover_objs:
			#print(obj)
			if obj == owner.clicked_obj:
				owner.clicked_obj = null
				break
			if obj is BuildPieceTest:
				owner.clicked_obj = obj
				obj.owner.toggle_built(false)
				#if obj.owner.built:
					#unbuilt_buildings.append(obj.owner)
				break
	if event.is_action_released("select") and owner.clicked_obj != null:
		if owner.clicked_obj is BuildPieceTest: owner.clicked_obj.slot()
		owner.clicked_obj = null
	
	if event.is_action_pressed("rotate_building") and build_mode:
		if owner.clicked_obj == null: pass
		if owner.clicked_obj is not BuildPieceTest: pass
		owner.clicked_obj.owner.rotation += PI/2
		while owner.clicked_obj.owner.rotation >= 2 * PI:
			owner.clicked_obj.owner.rotation -= 2 * PI
	
	if event.is_action_pressed("select") and not build_mode:
		for obj in owner.hover_objs:
			if obj is BuildPieceTest: obj.owner.work_click(ResourcesHolder.work_power)
	
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
	
	if not build_mode:
		for b : BaseBuilding in unbuilt_buildings:
			b.remove_building()
	for building : BaseBuilding in buildings.get_children():
		building.toggle_active(true, build_mode)

func toggle_active(toggle : bool) -> void:
	active = toggle
	
	visible = active
	
	for hb in hitbox_layer.get_children():
		hb.get_node("Area2D/CollisionShape2D").disabled = !active
	for build : BaseBuilding in get_node("Buildings").get_children():
		build.toggle_active(active, build_mode)


func _on_get_building_upgrade(upgrade: BaseUpgradeStrategy) -> void:
	for each in buildings.get_children():
		if upgrade.buildings == []: return
		
		if each is ManorBuilding and upgrade.buildings.has(upgrade.ValidBuildings.Manor):
			upgrade.add_upgrade(each)
		if each is MineBuilding and upgrade.buildings.has(upgrade.ValidBuildings.Mine):
			upgrade.add_upgrade(each)
		if each is FarmBuilding and upgrade.buildings.has(upgrade.ValidBuildings.Farm):
			upgrade.add_upgrade(each)
		if each is PastureBuilding and upgrade.buildings.has(upgrade.ValidBuildings.Pasture):
			upgrade.add_upgrade(each)


func _on_create_building(type: String, c_res : Array[String], c_amt : Array[int]) -> void:
	var b : PackedScene
	if type == "Mine":
		b = load("uid://t7vblyjuljk")
	elif type == "Farm":
		b = load("uid://bdjh06ean84vm")
	elif type == "Pasture":
		b = load("uid://cngww2dyqvc1j")
		
	var build : BaseBuilding = b.instantiate()
	buildings.add_child(build)
	unbuilt_buildings.append(build)
	
	build.active = false
	build.build_cost_res = c_res
	build.build_cost_amt = c_amt
