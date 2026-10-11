extends Node2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var hud: HUD = $HUD
@onready var game_screen: GameScreen = $GameScreen
@onready var upgrade_screen: UpgradesScreen = $UpgradesScreen

func _ready() -> void:
	_on_game_screen_pressed()

func _process(_delta: float) -> void:
	pass


func _on_upgrades_screen_pressed() -> void:
	print("upgrades")
	game_screen.toggle_active(false)
	upgrade_screen.toggle_active(true)


func _on_game_screen_pressed() -> void:
	print("game screen")
	game_screen.toggle_active(true)
	upgrade_screen.toggle_active(false)
