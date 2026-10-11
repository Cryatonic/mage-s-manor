extends Node2D
class_name ResourceGenerator

@warning_ignore("unused_signal")
signal generating(toggle : bool)
@warning_ignore("unused_signal")
signal change_resources(res_array : Array[Array])

#Resources: 
#Gold: Money, can be used to buy upgrades & other resources
#Knowledge: Research & Upgrades
#Arcane Esoterica: Research & Upgrades
#Food: Needed to feed staff
#Animal Products: Research & Upgrades; also generates Food
#Plant Products: Research & Upgrades; also generates Food
#Minerals: Research & Upgrades; also generates Gold

#Resource name, Resource Base, Resource Multiplier, Timer to Trigger, Time since last Trigger
@onready var resources : Array[Array] = [
	["Knowledge", 1.0, 1.0, 1.0, 0.0]
]
var is_generating : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not is_generating: return
	for x in range(0, resources.size()):
		resources[x][4] += _delta
		while resources[x][4] >= resources[x][3]:
			ResourcesHolder.emit_signal("get_resources", resources[x][0], resources[x][1] * resources[x][2])
			resources[x][4] -= resources[x][3]

func do_work(work_power : float = 0.0):
	for res in resources:
		res[4] += (1 + work_power) / 60.0

func _on_generating(toggle: bool) -> void:
	is_generating = toggle


func _on_change_resources(res_array: Array[Array]) -> void:
	#print(res_array)
	var valid_indexes : Array[int] = []
	for x in range(0, res_array.size()):
		#Check that the Array object is another Array
		if res_array[x] is not Array: continue
		#Check that Array has 5 variables
		if res_array[x].size() != 5: continue
		#Check that first variable is a String that is a Resource key
		if res_array[x][0] is not String: continue
		if not ResourcesHolder.resources_held.has(res_array[x][0]): continue
		#Check that the second and third variables are floats
		if res_array[x][1] is not float: continue
		if res_array[x][2] is not float: continue
		#Check that fourth variable is a float more than 0
		if res_array[x][3] is not float or res_array[x][2] <= 0: continue
		#Check that fifth variable is a float
		if res_array[x][4] is not float: continue
		valid_indexes.append(x)
	
	resources.clear()
	for i in valid_indexes:
		resources.append(res_array[i])
	#print(resources)
