extends Resource
class_name BaseUpgradeStrategy

enum UpgradeTypes {Player, PlayerBonus, Building}
#Player or Building Upgrade
@export var type: UpgradeTypes

enum ValidBuildings {None, Manor, Farm, Mine, Pasture}
@export var buildings : Array[ValidBuildings]

func obtain_upgrade() -> void:
	if type == UpgradeTypes.PlayerBonus:
		add_upgrade(ResourcesHolder.player_bonuses)
	elif type == UpgradeTypes.Player:
		add_upgrade(ResourcesHolder.player_upgrades)
	else:
		for building in Engine.get_main_loop().get_first_node_in_group("GameScreen").get_node("Buildings").get_children():
			if building is ManorBuilding and buildings.has(ValidBuildings.Manor):
				add_upgrade(building)
			elif building is FarmBuilding and buildings.has(ValidBuildings.Farm):
				add_upgrade(building)
			elif building is MineBuilding and buildings.has(ValidBuildings.Mine):
				add_upgrade(building)
			elif building is PastureBuilding and buildings.has(ValidBuildings.Pasture):
				add_upgrade(building)

func add_upgrade(up_obj) -> void:
	pass
	
func remove_upgrade(up_obj) -> void:
	pass
