extends BaseBuilding
class_name PastureBuilding

func set_resource_and_shape() -> void:
	resources = [
		["Animal Products", 3.0, 1.0, 7.5, 0.0],
		["Food", 3.0, 1.0, 7.5, 0.0]
	]
	
	shape = [
		[0,1,1,1,1,1,0],
		[0,1,1,1,1,1,0],
		[1,1,1,1,1,1,1],
		[1,1,1,1,1,1,1],
		[1,1,1,1,1,1,1]
	]
