extends Node2D
class_name MarketItem

@onready var action_button: Button = $ActionButton

@onready var inc_button: Button = $ActionButton/IncButton
@onready var dec_button: Button = $ActionButton/DecButton
@onready var amt_label: Label = $ActionButton/AmtLabel

@export var action_name : String
@export var action_desc : String

@export var multi_buy : bool

@export var cost_res : Array[String]
@export var cost_amt : Array[int]

var curr_amt : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_button.text = action_name
	action_button.tooltip_text = action_desc
	
	if not multi_buy:
		inc_button.visible = false
		inc_button.disabled = true
		
		dec_button.visible = false
		dec_button.disabled = true
		
		amt_label.visible = false
	else:
		amt_label.text = str(curr_amt)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func do_action() -> void:
	pass
	
func deduct_costs() -> void:
	for c in range(0, cost_res.size()):
		ResourcesHolder.resources_held[cost_res[c]] -= cost_amt[c] * curr_amt


func _on_action_button_pressed() -> void:
	for c in range(0, cost_res.size()):
		if ResourcesHolder.resources_held[cost_res[c]] < cost_amt[c] * curr_amt:
			print("Cannot buy.")
			return
	
	do_action()


func _on_inc_button_pressed() -> void:
	if curr_amt >= 10000: return
	
	curr_amt *= 10
	amt_label.text = str(curr_amt)


func _on_dec_button_pressed() -> void:
	if curr_amt <= 1: return
	
	curr_amt /= 10
	amt_label.text = str(curr_amt)
