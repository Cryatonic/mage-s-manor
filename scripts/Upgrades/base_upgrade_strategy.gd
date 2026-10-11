extends Resource
class_name BaseUpgradeStrategy

enum UpgradeTypes {Player, Building}
#Player or Building Upgrade
@export var type: UpgradeTypes

enum ValidBuildings {None, Manor, Farm, Mine, Pasture}
@export var buildings : Array[ValidBuildings]

func add_upgrade(up_obj : Node2D) -> void:
	pass
	
func remove_upgrade(up_obj : Node2D) -> void:
	pass
