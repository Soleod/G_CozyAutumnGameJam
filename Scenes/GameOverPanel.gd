extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("game_over", self, "_on_GameManager_game_over")

func _on_GameManager_game_over():
	self.show()
	GameManager.currentGameState = GameManager.GameState.GAMEOVER
