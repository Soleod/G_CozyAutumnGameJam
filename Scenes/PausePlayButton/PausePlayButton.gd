extends TextureButton

var pause: Texture
var unpause: Texture

func _ready():
	pause = load("res://Art/UI/Pause/Pause.png")
	unpause = load("res://Art/UI/Pause/Pause_paused.png")

func _pressed():
	match GameManager.currentGameState:
		GameManager.GameState.RUNNING:
			GameManager.ChangeGameState(GameManager.GameState.PAUSED)
			self.texture_normal = unpause
		GameManager.GameState.PAUSED:
			GameManager.ChangeGameState(GameManager.GameState.RUNNING)
			self.texture_normal = pause

