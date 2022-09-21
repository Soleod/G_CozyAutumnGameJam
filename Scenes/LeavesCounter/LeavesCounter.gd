extends Label


func _ready():
	GameManager.connect("inventory_changed", self, "_on_inventory_changed")
	self.text = String(GameManager.leaves)


func _on_inventory_changed():
	self.text = String(GameManager.leaves)
