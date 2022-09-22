extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	GameManager.connect("win", self, "_on_GameManager_win")

func _on_GameManager_win():
	self.show()
	GameManager.currentGameState = GameManager.GameState.WIN
	$Label.text = "You won!\n" + "You managed to save " + str(GameManager.hedgehogs) + " Hedgehogs!\n"
