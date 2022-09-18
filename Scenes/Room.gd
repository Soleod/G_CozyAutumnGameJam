extends Area2D

var buildingPanel: Panel
var outsidePanel: Panel
var roomSprite: Sprite
var progressBar: ProgressBar
var heatPanel: Panel
var roomShader: Material

var foodProduction: int = 0
var cost: int = 0
var lodging: int = 0

var coldness: int = 110

signal enable_next_room

func _ready():
	buildingPanel = $CanvasLayer/OutsidePanel/BuildingPanel
	outsidePanel = $CanvasLayer/OutsidePanel
	roomSprite = $Sprite
	roomShader = roomSprite.material
	
	
	GameManager.connect("clock_tick", self, "_on_GameManager_game_tick")

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

func _on_GameManager_game_tick():
	print("Cold", roomShader.get("shader_param/Coldness"))
	if(coldness != 110):
		coldness += 1
		if(coldness == 100):
			coldness = 100
		roomShader.set("shader_param/Coldness", coldness / 100.0)

func _on_OutsidePanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("Outside")
			buildingPanel.hide()
			outsidePanel.hide()
			GameManager.ChangeGameState(GameManager.GameState.RUNNING)

func BuildRoom(buildingTexture: StreamTexture):
	roomSprite.texture = buildingTexture
	buildingPanel.hide()
	outsidePanel.hide()
	GameManager.ChangeGameState(GameManager.GameState.RUNNING)
	emit_signal("enable_next_room")


func _on_BuildingEmpty_build_room(buildingName, buildingTexture):
	BuildRoom(buildingTexture)
	foodProduction = 0
	cost = 0
	lodging = 0
	coldness = 110


func _on_BuildingFood_build_room(buildingName, buildingTexture):
	BuildRoom(buildingTexture)
	foodProduction = 1
	cost = 10
	lodging = 0
	coldness = 0


func _on_BuildingSleep_build_room(buildingName, buildingTexture):
	BuildRoom(buildingTexture)
	foodProduction = 0
	cost = 10
	lodging = 5
	coldness = 0
