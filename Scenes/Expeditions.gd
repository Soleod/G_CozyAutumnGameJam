extends Control


var currentExpedition = null
var expeditionProgressScene
var expeditionButton: Node

func _ready():
	expeditionProgressScene = load("res://Scenes/ExpeditionProgress/ExpeditionProgress.tscn")
	expeditionButton = $ExpeditionButton
	expeditionButton.connect("expedition_started", self, "_on_expedition_started")


func _on_expedition_started():
	expeditionButton.hide()
	currentExpedition = expeditionProgressScene.instance()
	add_child(currentExpedition)
	currentExpedition.connect("expedition_finished", self, "_on_expedition_finished")

func _on_expedition_finished():
	expeditionButton.show()
	match(randi() % 3):
		0:
			GameManager.sticks += (randi() % 5 + 1) * 10
		1:
			GameManager.leaves += (randi() % 5 + 1) * 10
		2:
			GameManager.food += (randi() % 5 + 1) * 10
