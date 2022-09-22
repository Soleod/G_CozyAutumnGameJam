extends Node

enum GameState {
	RUNNING,
	PAUSED,
	BUILDING,
	EXPEDITION
}

enum Temperature {
	WARM,
	CHILLY,
	COLD,
	FROSTPUNK
}

var currentGameState: int
var gameTickTimer: Timer
var PauseButton: TextureButton

var food: int = 0
var sticks: int = 0
var leaves: int = 0
var hedgehogs: int = 5

var hour: int = 0
var day: int = 0
var currentTemp: int


signal game_tick
signal clock_tick
signal state_change(currentGameState)
signal inventory_changed

func _ready():
	currentGameState = GameState.RUNNING
	gameTickTimer = Timer.new()
	add_child(gameTickTimer)
	gameTickTimer.connect("timeout", self, "_on_Timer_timeout")
	gameTickTimer.set_wait_time(0.8)
	gameTickTimer.set_one_shot(false)
	gameTickTimer.start()

func _unhandled_input(event):
	match currentGameState: 
		GameState.RUNNING:
			if event is InputEventKey:
				if event.pressed and event.scancode == KEY_SPACE:
					ChangeGameState(GameState.PAUSED)
					
		GameState.PAUSED:
			if event is InputEventKey:
				if event.pressed and event.scancode == KEY_SPACE:
					ChangeGameState(GameState.RUNNING) 


func ChangeGameState(newGameState):
	print(currentGameState, " -> ", newGameState)
	currentGameState = newGameState
	emit_signal("state_change", currentGameState)

func _on_Timer_timeout():
	if currentGameState == GameState.RUNNING:
		if(hour == 0):
			hour += 1
			emit_signal("clock_tick")
			emit_signal("game_tick")
		else:
			hour += 1
			if hour == 8:
				hour = 0
			emit_signal("clock_tick")


func add_leaves(amount):
	leaves += amount
	emit_signal("inventory_changed")

func add_food(amount):
	food += amount
	emit_signal("inventory_changed")

func add_sticks(amount):
	sticks += amount
	emit_signal("inventory_changed")
	
func remove_sticks(amount):
	print("Kakao: ", sticks)
	sticks -= amount
	print("Makarena: ", sticks)
	emit_signal("inventory_changed")
