extends Area2D

var buildingPanel: Panel
var outsidePanel: Panel
var roomSprite: Sprite

func _ready():
	buildingPanel = $CanvasLayer/OutsidePanel/BuildingPanel
	outsidePanel = $CanvasLayer/OutsidePanel
	roomSprite = $Sprite

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		self.on_click()

func on_click():
	print("Click")
	buildingPanel.show()
	outsidePanel.show()
	GameManager.ChangeGameState(GameManager.GameState.BUILDING)

func _on_OutsidePanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("Outside")
			buildingPanel.hide()
			outsidePanel.hide()
			GameManager.ChangeGameState(GameManager.GameState.RUNNING)


func _on_BuildingPanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("Building")

func _on_Building_build_room(buildingName, buildingTexture):
	roomSprite.texture = buildingTexture
	buildingPanel.hide()
	outsidePanel.hide()
	GameManager.ChangeGameState(GameManager.GameState.RUNNING)


func _on_Building2_build_room(buildingName, buildingTexture):
	roomSprite.texture = buildingTexture
	buildingPanel.hide()
	outsidePanel.hide()
	GameManager.ChangeGameState(GameManager.GameState.RUNNING)


func _on_Building3_build_room(buildingName, buildingTexture):
	roomSprite.texture = buildingTexture
	buildingPanel.hide()
	outsidePanel.hide()
	GameManager.ChangeGameState(GameManager.GameState.RUNNING)
