extends MarketItem

func do_action() -> void:
	if curr_amt % 5 != 0: 
		print("Too small an amount to sell.")
		return
	ResourcesHolder.emit_signal("get_resources", "Gold", 0.2 * curr_amt)
	
	deduct_costs()
