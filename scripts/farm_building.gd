extends BaseBuilding
class_name FarmBuilding

func set_resource_and_shape() -> void:
	resources = [
		["Plant Products", 1.0, 2.5, 0.0],
		["Food", 1.0, 2.5, 0.0]
	]
	
	shape = [
		[1,1,0,0,0,0],
		[1,1,1,1,1,1],
		[0,1,1,1,1,1],
		[0,1,1,1,1,1],
		[0,1,1,1,1,1],
		[0,1,1,1,1,1]
	]
