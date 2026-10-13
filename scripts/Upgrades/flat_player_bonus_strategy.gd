extends BaseUpgradeStrategy
class_name FlatPlayerBonusStrategy

func add_upgrade(up_obj) -> void:
	up_obj[res_type][0] += bonus
	
func remove_upgrade(up_obj) -> void:
	up_obj[res_type][0] -= bonus
