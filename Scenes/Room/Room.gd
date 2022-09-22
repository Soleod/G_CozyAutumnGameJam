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
var coldProtectionLevel: int = GameManager.TemperatureState.FROSTPUNK
var coldness: float = 0
var isActive: bool = true

signal enable_next_room(roomName)

func _ready():
	buildingPanel = $CanvasLayer/OutsidePanel/BuildingPanel
	outsidePanel = $CanvasLayer/OutsidePanel
	roomSprite = $Sprite
	roomShader = roomSprite.material
	
	
	GameManager.connect("game_tick", self, "_on_GameManager_game_tick")

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
	if(coldProtectionLevel < GameManager.currentTempState):
		if(coldness >= 100):
			coldness = 100
			isActive = false
			roomShader.set("shader_param/Coldness", coldness / 100)
		else:
			coldness += 25
			roomShader.set("shader_param/Coldness", coldness / 100)

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
	var currentRoomIndex = self.name.get_slice("_", 1)
	var nextRoomIndex = int(currentRoomIndex) + 1
	if (nextRoomIndex != 4 and nextRoomIndex != 7 and nextRoomIndex != 10):
		$Sprite/SpriteLO.show()
		$Sprite/SpriteLC.hide()
		$Sprite/SpriteLO/NavigationPolygonInstance.enabled = true
	emit_signal("enable_next_room", self.name.get_slice("_", 0) + "_" + String(nextRoomIndex))

func _on_BuildingEmpty_build_room(buildingName, buildingTexture):
	var tmpCost = 0
	if (GameManager.sticks >= tmpCost):
		GameManager.remove_sticks(tmpCost)
		foodProduction = 0
		cost = tmpCost
		lodging = 0
		coldness = 0
		isActive = true
		coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK
		BuildRoom(buildingTexture)


func _on_BuildingFood_build_room(buildingName, buildingTexture):
	var tmpCost = 10
	if (GameManager.sticks >= tmpCost):
		GameManager.remove_sticks(tmpCost)
		foodProduction = 1
		cost = tmpCost
		lodging = 0
		coldness = 0
		isActive = true
		coldProtectionLevel = GameManager.TemperatureState.WARM
		BuildRoom(buildingTexture)


func _on_BuildingSleep_build_room(buildingName, buildingTexture):
	var tmpCost = 10
	if (GameManager.sticks >= tmpCost):
		GameManager.remove_sticks(tmpCost)
		foodProduction = 0
		cost = tmpCost
		lodging = 5
		coldness = 0
		isActive = true
		coldProtectionLevel = GameManager.TemperatureState.WARM
		BuildRoom(buildingTexture)


func _on_Room1_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room2_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room4_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room7_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room8_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room_5_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true
