extends MarketItem
class_name BuyBuilding

@export var build_name : String

func do_action() -> void:
	print("Bought " + build_name)
	get_tree().get_first_node_in_group("GameScreen").emit_signal("create_building", build_name, cost_res, cost_amt)
	
	deduct_costs()
