extends MarketItem
class_name BuyFarm

func do_action() -> void:
	print("Bought Farm.")
	get_tree().get_first_node_in_group("GameScreen").emit_signal("create_building", "Farm")
	
	deduct_costs()
