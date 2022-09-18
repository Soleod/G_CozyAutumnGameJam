extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("game_tick", self, "_on_GameManager_game_tick")
	self.text = "Food: " + String(GameManager.food)


func _on_GameManager_game_tick():
	self.text = "Food: " + String(GameManager.food)
