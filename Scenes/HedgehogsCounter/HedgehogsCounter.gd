extends Label


func _ready():
	GameManager.connect("clock_tick", self, "_on_GameManager_clock_tick")
	self.text = String(GameManager.hedgehogs)


func _on_GameManager_clock_tick():
	self.text = String(GameManager.hedgehogs)
