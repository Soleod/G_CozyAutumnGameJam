extends Control


var currentExpedition = null
var expeditionProgressScene
var expeditionButton: Node
var buildingGrid: Node
var hedgehog: Node

func _ready():
	expeditionProgressScene = load("res://Scenes/ExpeditionProgress/ExpeditionProgress.tscn")
	expeditionButton = $ExpeditionButton
	buildingGrid = get_node("/root/Game/World/BuildingGrid")

func _on_expedition_started():
	hedgehog = buildingGrid.hedgehogs[randi() % buildingGrid.hedgehogs.size()]
	hedgehog.start_expedition()
	expeditionButton.hide()
	currentExpedition = expeditionProgressScene.instance()
	add_child(currentExpedition)
	currentExpedition.connect("expedition_finished", self, "_on_expedition_finished")

func _on_expedition_finished():
	hedgehog.finish_expedition()
	expeditionButton.show()
	match(randi() % 3):
		0:
			GameManager.add_sticks((randi() % 9 + 4))
		1:
			GameManager.add_leaves((randi() % 5 + 2))
		2:
			GameManager.add_food((randi() % 21 + 10))
