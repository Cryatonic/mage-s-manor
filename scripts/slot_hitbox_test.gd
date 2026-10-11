extends Node2D
class_name SlotHitboxTest

@warning_ignore("unused_signal")
signal find_nearest_tile_center

@onready var area_2d: Area2D = $Area2D

var parent : Node2D
var valid_hover_tile_slot : bool = false
var valid_slot_pos : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_parent(p : Node2D):
	parent = p


func _on_area_2d_mouse_entered() -> void:
	pass
	#print(parent)


func _on_find_nearest_tile_center() -> void:
	valid_hover_tile_slot = false
	valid_slot_pos = Vector2.ZERO
	
	var areas = area_2d.get_overlapping_areas()
	if areas.size() == 0:
		return
	
	var dist_between_centers : Vector2
	var other_slot_hitboxes : Array[Vector2] = []
	for a in areas:
		#if a.owner is not TestTilesetScene: continue
		if a.owner is SlotHitboxTest: other_slot_hitboxes.append(a.owner.valid_slot_pos)
		dist_between_centers = global_position - a.global_position
		if dist_between_centers.length() <= 8 and a.owner is TestTilesetScene:
			valid_hover_tile_slot = true
			valid_slot_pos = a.global_position
			a.owner.hovering = true
	
	for s in other_slot_hitboxes:
		if s == valid_slot_pos:
			#print("Another Piece Rests Here")
			valid_hover_tile_slot = false
			valid_slot_pos = Vector2.ZERO
			return
	
	#print(str(self) + ": " + str(valid_hover_tile_slot) + " at " + str(valid_slot_pos))
