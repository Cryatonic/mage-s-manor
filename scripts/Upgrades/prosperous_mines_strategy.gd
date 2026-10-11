extends BaseUpgradeStrategy
class_name ProsMinesStrategy

func add_upgrade(up_obj) -> void:
	for res in up_obj.resources:
		if res[0] == "Minerals":
			res[1] += 1.0
		elif res[0] == "Gold":
			res[1] += 1.0
	
func remove_upgrade(up_obj) -> void:
	for res in up_obj.resources:
		if res[0] == "Minerals":
			res[1] -= 1.0
		elif res[0] == "Gold":
			res[1] -= 1.0
