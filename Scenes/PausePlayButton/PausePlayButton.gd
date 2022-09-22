extends TextureButton

var pause: Texture
var unpause: Texture

func _ready():
	pause = load("res://Art/UI/Pause/Pause.png")
	unpause = load("res://Art/UI/Pause/Pause_paused.png")
	GameManager.connect("state_change", self, "on_state_change")

func _pressed():
	match GameManager.currentGameState:
		GameManager.GameState.RUNNING:
			GameManager.ChangeGameState(GameManager.GameState.PAUSED)
		GameManager.GameState.PAUSED:
			GameManager.ChangeGameState(GameManager.GameState.RUNNING)


func on_state_change(current_state):
	match current_state:
		GameManager.GameState.RUNNING:
			self.texture_normal = unpause
		GameManager.GameState.PAUSED:
			self.texture_normal = pause
