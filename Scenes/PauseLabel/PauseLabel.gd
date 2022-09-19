extends Label

func _ready():
	GameManager.connect("state_change", self, "_on_GameManager_state_change")

func _on_GameManager_state_change(currentGameState):
	if currentGameState == GameManager.GameState.PAUSED:
		self.visible = true
	if currentGameState == GameManager.GameState.RUNNING:
		self.visible = false
