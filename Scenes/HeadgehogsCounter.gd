extends Label


func _ready():
	GameManager.connect("game_tick", self, "_on_GameManager_game_tick")
	self.text = "Headgehogs: " + String(GameManager.food)


func _on_GameManager_game_tick():
	self.text = "Headgehogs: " + String(GameManager.hedgehogs)
