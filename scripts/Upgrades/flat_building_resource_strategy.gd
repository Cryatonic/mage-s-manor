extends BaseUpgradeStrategy
class_name FlatBuildingResourceStrategy

func add_upgrade(up_obj) -> void:
	for res in up_obj.resources:
		if res[0] == res_type:
			res[1] += bonus

func remove_upgrade(up_obj) -> void:
	for res in up_obj.resources:
		if res[0] == res_type:
			res[1] = bonus
