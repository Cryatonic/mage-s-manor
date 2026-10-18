extends Node2D
class_name BuildPieceTest

@export var shape_layout : Array[Array] = []

@onready var sprite_tiles: Node2D = $SpriteTiles
@onready var hitbox_tiles: Node2D = $HitboxTiles

@export var home_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_shape(shape_layout)
	
	await get_tree().process_frame
	home_pos = global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func make_shape(s : Array[Array]) -> void:
	shape_layout = s
	build_piece_shape()
	for each in hitbox_tiles.get_children():
		each.set_parent(self)

func build_piece_shape() -> void:
	if shape_layout == []: return
	
	var build_height : int = shape_layout.size()
	var build_width : int = shape_layout[0].size()
	
	for each in shape_layout:
		if each.size() != build_width:
			print("Invalid Layout")
			return
	
	var hitbox : PackedScene = load("uid://cnvg0n1m4drv8")
	var sprite : Sprite2D
	for y in range(0, build_height):
		for x in range(0, build_width):
			var pos : Vector2 = Vector2(0,0)
			if build_height % 2 == 0:
				pos.y = (16 * y) - (8 * build_height) + 8
			else:
				pos.y = (16 * y) - (8 * (build_height - 1))
			if build_width % 2 == 0:
				pos.x = (16 * x) - (8 * build_width) + 8
			else:
				pos.x = (16 * x) - (8 * (build_width - 1))
			
			if shape_layout[y][x] == 0: continue
			var hb : SlotHitboxTest = hitbox.instantiate()
			hitbox_tiles.add_child(hb)
			hb.position = pos
			
			sprite = Sprite2D.new()
			sprite_tiles.add_child(sprite)
			sprite.texture = load("res://icon.svg")
			sprite.region_enabled = true
			sprite.region_rect.size = Vector2(16,16)
			sprite.position = pos
	
func hovering() -> void:
	var hitbox_children = hitbox_tiles.get_children()
	
	for each : SlotHitboxTest in hitbox_children:
		each.emit_signal("find_nearest_tile_center")

func slot() -> void:
	var hitbox_children = hitbox_tiles.get_children()
	
	for each : SlotHitboxTest in hitbox_children:
		each.emit_signal("find_nearest_tile_center")
	for each : SlotHitboxTest in hitbox_children:
		if not each.valid_hover_tile_slot:
			print("Can't Go There")
			global_position = home_pos
			owner.toggle_built(false)
			return
	
	var total_glob_pos : Vector2 = Vector2.ZERO
	var total_pos : Vector2 = Vector2.ZERO
	var rot_mod = int(owner.rotation / (PI / 2))
	
	for hb in hitbox_children:
		#if hb.position == Vector2.ZERO: global_position = hb.valid_slot_pos
		total_glob_pos += hb.valid_slot_pos
		if rot_mod % 4 == 0:
			total_pos += hb.position
		elif rot_mod % 4 == 1:
			total_pos.x += -hb.position.y
			total_pos.y += hb.position.x
		elif rot_mod % 4 == 2:
			total_pos.x += -hb.position.x
			total_pos.y += -hb.position.y
		elif rot_mod % 4 == 3:
			total_pos.x += hb.position.y
			total_pos.y += -hb.position.x
		#total_pos += hb.position
	
	total_glob_pos /= hitbox_children.size()
	total_pos /= hitbox_children.size()
	
	global_position = total_glob_pos - total_pos
	#owner.emit_signal("build_building")
	owner.toggle_built(true)
	#owner.built = true

func toggle_active(toggle : bool) -> void:
	for hb in hitbox_tiles.get_children():
		hb.get_node("Area2D/CollisionShape2D").disabled = !toggle
