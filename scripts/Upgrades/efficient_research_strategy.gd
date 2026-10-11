extends BaseUpgradeStrategy
class_name EfficResStrategy

func add_upgrade(up_obj) -> void:
	up_obj["Knowledge"][1] += 1.0
	
func remove_upgrade(up_obj) -> void:
	up_obj["Knowledge"][1] -= 1.0
