extends Node

enum GameState {
	RUNNING,
	PAUSED,
	BUILDING,
	EXPEDITION,
	GAMEOVER
}

enum TemperatureState {
	WARM,
	CHILLY,
	COLD,
	FROSTPUNK
}

var currentGameState: int
var gameTickTimer: Timer
var PauseButton: TextureButton

var food: int = 10
var sticks: int = 100
var leaves: int = 0
var hedgehogs: int = 1

var hour: int = 2
var sec: int = 0
var day: int = 0
var currentTemp: int = 31
var currentTempState: int = TemperatureState.WARM

var tick_rate: float = 1.5

signal game_tick
signal clock_tick
signal sec_clock_tick
signal state_change(currentGameState)
signal inventory_changed
signal game_over

func _ready():
	currentGameState = GameState.RUNNING
	gameTickTimer = Timer.new()
	add_child(gameTickTimer)
	gameTickTimer.connect("timeout", self, "_on_Timer_timeout")
	gameTickTimer.set_wait_time(tick_rate)
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
				day += 1
				if (day % 3 == 0):
					currentTemp -= 1
					if currentTemp <= 0:
						currentTemp = 0
				if currentTemp > 23:
					currentTempState = TemperatureState.WARM
				elif currentTemp > 15:
					currentTempState = TemperatureState.CHILLY
				elif currentTemp > 7:
					currentTempState = TemperatureState.COLD
				else:
					currentTempState = TemperatureState.FROSTPUNK
				print("Day: ", day, " Temp: ", currentTemp, " Temp State: ", currentTempState)
			emit_signal("clock_tick")
			if (food < 0):
				emit_signal("game_over")


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
	sticks -= amount
	emit_signal("inventory_changed")
