extends BaseBuilding
class_name MineBuilding

func set_resource_and_shape() -> void:
	resources = [
		["Minerals", 3.0, 1.0, 7.5, 0.0],
		["Gold", 1.0, 1.0, 15.0, 0.0]
	]
	shape = [
		[1,1,1],
		[1,1,1],
		[1,0,1]
	]
