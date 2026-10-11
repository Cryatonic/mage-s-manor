extends Node
class_name ResHolder

signal get_resources(res : String, amt : int)

#Resources: 
#Gold: Money, can be used to buy upgrades & other resources
#Knowledge: Research & Upgrades
#Arcane Esoterica: Research & Upgrades
#Food: Needed to feed staff
#Animal Products: Research & Upgrades; also generates Food
#Plant Products: Research & Upgrades; also generates Food
#Minerals: Research & Upgrades; also generates Gold
var resources_held : Dictionary[String, float] = {
	"Gold": 0.0,
	"Knowledge": 0.0,
	"Arcane Esoterica": 0.0,
	"Food": 0.0,
	"Animal Products": 0.0,
	"Plant Products": 0.0,
	"Minerals": 0.0
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_get_resources(res: String, amt: int) -> void:
	if not resources_held.has(res): return
	resources_held[res] += amt
