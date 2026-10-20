extends MarketItem
class_name BuyAnimalProducts

func do_action() -> void:
	ResourcesHolder.emit_signal("get_resources", "Animal Products", 2.0 * curr_amt)
	
	deduct_costs()
