extends Node2D
class_name TestTilesetScene

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D

var hovering : bool = false
var active : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	piece_hover(hovering)


func _on_area_2d_mouse_entered() -> void:
	pass


func _on_area_2d_mouse_exited() -> void:
	pass # Replace with function body.

func piece_hover(hov : bool = false) -> void:
	if not active: return
	if hov:
		sprite_2d.self_modulate.a8 = 100
		hovering = false
		return
	sprite_2d.self_modulate.a8 = 0

func toggle_tile_active(toggle : bool = true) -> void:
	active = toggle
	if not active:
		sprite_2d.self_modulate.a8 = 200
		area_2d.set_deferred("monitorable", false)
		#print(sprite_2d.self_modulate.a8)
	else:
		sprite_2d.self_modulate.a8 = 0
		area_2d.set_deferred("monitorable", true)
