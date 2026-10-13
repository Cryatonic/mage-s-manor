extends BaseUpgradeStrategy
class_name MultiBuildingResourceStrategy

func add_upgrade(up_obj) -> void:
	for res in up_obj.resources:
		if res[0] == res_type:
			res[2] += bonus

func remove_upgrade(up_obj) -> void:
	for res in up_obj.resources:
		if res[0] == res_type:
			res[2] = bonus
