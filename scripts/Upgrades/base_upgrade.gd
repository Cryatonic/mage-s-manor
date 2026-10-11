extends Node2D
class_name BaseUpgrade

@warning_ignore("unused_signal")
signal clicked

@onready var description: Label = $Description
@export var effect_desc : String

@export var upgrades : Array[BaseUpgradeStrategy]

@export var max_num_buy : int = 0
var curr_num_buy : int = 0

@export var upgrade_name : String = ""
@export var upgrade_costs : Array[Array] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_upgrade_costs()
	determine_upgrade_costs(upgrade_costs.duplicate())
	
	update_label()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_upgrade_costs() -> void:
	pass

func determine_upgrade_costs(up_list : Array[Array]) -> void:
	var valid_upgrade_indexes : Array[int] = []
	
	for u in range(0, upgrade_costs.size()):
		#Check that variable is an 2-long Array 
		if up_list[u] is not Array: continue
		if up_list[u].size() != 2: continue
		#Check that first variable is a Resource key
		if up_list[u][0] is not String: continue
		if not ResourcesHolder.resources_held.has(up_list[u][0]): continue
		#Check that second variable is an integer
		if up_list[u][1] is not int: continue
		valid_upgrade_indexes.append(u)
	
	upgrade_costs.clear()
	for i in valid_upgrade_indexes:
		upgrade_costs.append(up_list[i])

func buy_upgrade() -> void:
	if curr_num_buy >= max_num_buy: return
	
	var can_buy : bool = true
	
	for cost in upgrade_costs:
		if ResourcesHolder.resources_held[cost[0]] < cost[1] * (pow(2, curr_num_buy)): 
			can_buy = false
			break
	
	if can_buy:
		for cost in upgrade_costs:
			ResourcesHolder.resources_held[cost[0]] -= cost[1] * (pow(2, curr_num_buy))
		curr_num_buy += 1
		for each : BaseUpgradeStrategy in upgrades:
			each.obtain_upgrade()
		print("Bought: " + upgrade_name)
	else: print("Cannot Afford: " + upgrade_name)

func update_label() -> void:
	description.text = upgrade_name
	description.text += "\n\n"
	description.text += effect_desc
	description.text += "\n\n"
	description.text += "Cost: "
	for up in upgrade_costs:
		description.text += "\n"
		description.text += up[0] + ": " + str(int(up[1] * (pow(2, curr_num_buy))))
	description.text += "\n\nPurchased: " + str(curr_num_buy) + "/" + str(max_num_buy)
	
	description.position.y = -description.size.y / 2

func _on_area_2d_mouse_entered() -> void:
	update_label()
	description.visible = true


func _on_clicked() -> void:
	print(upgrade_name + " was clicked.")
	buy_upgrade()
	update_label()


func _on_area_2d_mouse_exited() -> void:
	description.visible = false
