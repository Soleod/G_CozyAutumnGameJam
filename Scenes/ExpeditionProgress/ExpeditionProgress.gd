extends Control

var hedgehog: Sprite
var startPos:Vector2
var endPos:Vector2
export var expeditionTime = 20
var progress = 0

signal expedition_finished


func _ready():
	hedgehog = get_node("AHedgehog")
	startPos = get_node("StartPos").position
	endPos = get_node("EndPos").position


func _process(delta):
	if GameManager.currentGameState == GameManager.GameState.RUNNING:
		progress += delta/expeditionTime * (1.0 / GameManager.tick_rate)
		hedgehog.position = startPos.linear_interpolate(endPos, progress)
		if progress >= 1:
			emit_signal("expedition_finished")
			free()
