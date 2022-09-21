extends Label


func _ready():
	GameManager.connect("game_tick", self, "_on_GameManager_game_tick")
	self.text = String(GameManager.hedgehogs)


func _on_GameManager_game_tick():
	self.text = String(GameManager.hedgehogs)
