extends MarketItem
class_name BuyFarm

func do_action() -> void:
	print("Bought Farm.")
	
	deduct_costs()
