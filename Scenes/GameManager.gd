extends Node

enum GameState {
	RUNNING,
	PAUSED,
	BUILDING
}

var currentGameState: int
var gameTickTimer: Timer

signal game_tick
signal state_change(currentGameState)

func _ready():
	currentGameState = GameState.RUNNING
	
	gameTickTimer = Timer.new()
	add_child(gameTickTimer)
	gameTickTimer.connect("timeout", self, "_on_Timer_timeout")
	gameTickTimer.set_wait_time(2.0)
	gameTickTimer.set_one_shot(false)
	gameTickTimer.start()

func _unhandled_input(event):
	match currentGameState:
		GameState.RUNNING:
			if event is InputEventKey:
				if event.pressed and event.scancode == KEY_SPACE:
					currentGameState = GameState.PAUSED
					emit_signal("state_change", currentGameState)
		GameState.PAUSED:
			if event is InputEventKey:
				if event.pressed and event.scancode == KEY_SPACE:
					currentGameState = GameState.RUNNING
					emit_signal("state_change", currentGameState)

func _on_Timer_timeout():
	if currentGameState == GameState.RUNNING:
		emit_signal("game_tick")
