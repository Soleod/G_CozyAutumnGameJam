extends Area2D

var buildingPanel: Panel
var outsidePanel: Panel
var roomSprite: Sprite
var progressBar: ProgressBar
var heatPanel: Panel
var roomShader: Material
var notEnoughResDialog: Panel

var foodProduction: int = 0
var cost: int = 0
var lodging: int = 0
var coldProtectionLevel: int = GameManager.TemperatureState.FROSTPUNK
var coldness: float = 0
var isActive: bool = true

signal spawn_hedgehog()
signal enable_next_room(roomName)

func _ready():
	buildingPanel = $CanvasLayer/OutsidePanel/BuildingPanel
	outsidePanel = $CanvasLayer/OutsidePanel
	roomSprite = $Sprite
	roomShader = roomSprite.material
	notEnoughResDialog = $CanvasLayer/NotEnoughRes
	
	GameManager.connect("game_tick", self, "_on_GameManager_game_tick")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		self.on_click()

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE) \
	and buildingPanel.visible:
		buildingPanel.hide()
		outsidePanel.hide()
		GameManager.ChangeGameState(GameManager.GameState.RUNNING)
		

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

func getRoomProperties(buildingName):
	match buildingName:
		"MushroomRoom":
			return {
				"costSticks": 4,
				"costLeaves": 2,
				"hedgehogGain": 0,
				"dailyFood": 1,
				"roomTexture": $Sprite/SpriteShrooms
			}
		"SleepingRoom":
			return {
				"costSticks": 5,
				"costLeaves": 1,
				"hedgehogGain": 1,
				"dailyFood": 0,
				"roomTexture": $Sprite/SpriteSleep
			}

func _on_BuildingPanel_build_room(buildingName):
	
	var room = getRoomProperties(buildingName)
	
	if GameManager.sticks < room.costSticks:
		notEnoughResDialog.show()
		return
	
	if GameManager.leaves < room.costLeaves:
		notEnoughResDialog.show()
		return
	
	GameManager.remove_sticks(room.costSticks)
	GameManager.remove_leaves(room.costLeaves)
	lodging = room.hedgehogGain
	for x in range(lodging):
		emit_signal("spawn_hedgehog")
	coldness = 0
	isActive = true
	foodProduction = room.dailyFood
	coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK
	
	buildingPanel.hide()
	outsidePanel.hide()
	room.roomTexture.show()
	
	GameManager.ChangeGameState(GameManager.GameState.RUNNING)
	var currentRoomIndex = self.name.get_slice("_", 1)
	var nextRoomIndex = int(currentRoomIndex) + 1
	if (nextRoomIndex != 4 and nextRoomIndex != 7 and nextRoomIndex != 10):
		$Sprite/SpriteLO.show()
		$Sprite/SpriteLC.hide()
		$Sprite/SpriteLO/NavigationPolygonInstance.enabled = true
	emit_signal("enable_next_room", self.name.get_slice("_", 0) + "_" + String(nextRoomIndex))


func _on_Room_1_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room_2_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room_4_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room_5_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room_7_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Room_8_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true


func _on_Close_pressed():
	buildingPanel.hide()
	outsidePanel.hide()
	GameManager.ChangeGameState(GameManager.GameState.RUNNING)
