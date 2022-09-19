extends TextureButton


func _pressed():
	match GameManager.currentGameState:
		GameManager.GameState.RUNNING:
			GameManager.ChangeGameState(GameManager.GameState.PAUSED)
		GameManager.GameState.PAUSED:
			GameManager.ChangeGameState(GameManager.GameState.RUNNING)

