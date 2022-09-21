extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("inventory_changed", self, "_on_inventory_changed")
	self.text = String(GameManager.food)


func _on_inventory_changed():
	self.text = String(GameManager.food)
