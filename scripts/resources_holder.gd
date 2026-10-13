extends Node
class_name ResHolder

@warning_ignore("unused_signal")
signal get_resources(res : String, amt : int)
@warning_ignore("unused_signal")
signal get_upgrade(upgrade : BaseUpgrade)

#Resources: 
#Gold: Money, can be used to buy upgrades & other resources
#Knowledge: Research & Upgrades
#Arcane Esoterica: Research & Upgrades
#Food: Needed to feed staff
#Animal Products: Research & Upgrades; also generates Food
#Plant Products: Research & Upgrades; also generates Food
#Minerals: Research & Upgrades; also generates Gold
var resources_held : Dictionary[String, float] = {
	"Gold": 0.0,
	"Knowledge": 0.0,
	"Arcane Esoterica": 0.0,
	"Food": 0.0,
	"Animal Products": 0.0,
	"Plant Products": 0.0,
	"Minerals": 0.0
}

var work_power : float = 20000.0
var player_upgrades : Array[BaseUpgradeStrategy] = []
#Flat Bonus, Multiplier
var player_bonuses : Dictionary[String, Array] = {
	"Gold": [0.0, 1.0],
	"Knowledge": [0.0, 1.0],
	"Arcane Esoterica": [0.0, 1.0],
	"Food": [0.0, 1.0],
	"Animal Products": [0.0, 1.0],
	"Plant Products": [0.0, 1.0],
	"Minerals": [0.0, 1.0]
}
var building_upgrades : Array[BaseUpgradeStrategy] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_get_resources(res: String, amt: int) -> void:
	if not resources_held.has(res): return
	resources_held[res] += (amt + player_bonuses[res][0]) * player_bonuses[res][1]


func _on_get_upgrade(upgrade: BaseUpgradeStrategy) -> void:
	if upgrade.type == upgrade.UpgradeTypes.PlayerBonus:
		upgrade.add_upgrade(player_bonuses)
	elif upgrade.type == upgrade.UpgradeTypes.Player:
		player_upgrades.append(upgrade)
		upgrade.add_upgrade(null)
	elif upgrade.type == upgrade.UpgradeTypes.Building:
		building_upgrades.append(upgrade)
		get_tree().get_first_node_in_group("GameScreen").emit_signal("get_building_upgrade", upgrade)
