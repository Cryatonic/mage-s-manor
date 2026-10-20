extends MarketItem
class_name BuyResource

@export var res_buy : String
@export var res_amt_per : int

func do_action() -> void:
	ResourcesHolder.emit_signal("get_resources", res_buy, res_amt_per * curr_amt)
	
	deduct_costs()

func res_text() -> String:
	return action_desc.replace("AMT", str(res_amt_per * curr_amt))
