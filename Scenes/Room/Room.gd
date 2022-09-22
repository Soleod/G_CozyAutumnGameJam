extends Area2D

# Lose all hope ye who enter here

var buildingPanel: Panel
var outsidePanel: Panel
var roomSprite: Sprite
var progressBar: ProgressBar
var heatPanel: Panel
var roomShader: Material
var notEnoughResDialog: Panel
var upgradeButton: TextureButton

var upgrade1: Texture
var upgrade2: Texture
var upgrade3: Texture
var upgrade4: Texture

var foodProduction: int = 0
var cost: int = 0
var lodging: int = 0
var coldProtectionLevel: int = GameManager.TemperatureState.FROSTPUNK
var coldness: float = 0

var roomType: String = "Empty"

signal spawn_hedgehog()
signal enable_next_room(roomName)

func _ready():
	buildingPanel = $CanvasLayer/OutsidePanel/BuildingPanel
	outsidePanel = $CanvasLayer/OutsidePanel
	roomSprite = $Sprite
	roomShader = roomSprite.material
	notEnoughResDialog = $CanvasLayer/NotEnoughRes
	upgradeButton = $UpgradeButton
	
	upgrade1 = load("res://Art/Shroom Room/AddLeaves_1.png")
	upgrade2 = load("res://Art/Shroom Room/AddLeaves_2.png")
	upgrade3 = load("res://Art/Shroom Room/AddLeaves_3.png")
	upgrade4 = load("res://Art/Shroom Room/AddLeaves_4.png")
	
	upgradeButton.texture_normal = upgrade1
	
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
			roomShader.set("shader_param/Coldness", coldness / 100)
		else:
			coldness += 25
			roomShader.set("shader_param/Coldness", coldness / 100)
	if(coldness >= 100):
		match roomType:
			"Empty":
				pass
			"MushroomRoom":
				foodProduction = 0
			"SleepingRoom":
				foodProduction = -1

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
				"roomTexture": $Sprite/SpriteShrooms,
				"coldProtectionLevel": GameManager.TemperatureState.WARM
			}
		"SleepingRoom":
			return {
				"costSticks": 5,
				"costLeaves": 1,
				"hedgehogGain": 1,
				"dailyFood": 0,
				"roomTexture": $Sprite/SpriteSleep,
				"coldProtectionLevel": GameManager.TemperatureState.WARM
			}

func _on_BuildingPanel_build_room(buildingName):
	
	var room = getRoomProperties(buildingName)
	roomType = buildingName
	
	if GameManager.sticks < room.costSticks:
		notEnoughResDialog.show()
		return
	
	if GameManager.leaves < room.costLeaves:
		notEnoughResDialog.show()
		return
	
	GameManager.remove_sticks(room.costSticks)
	GameManager.remove_leaves(room.costLeaves)
	lodging = room.hedgehogGain
	print("GAIN: " + str(lodging))
	for x in range(lodging):
		print("DSADSA")
		emit_signal("spawn_hedgehog")
	coldness = 0
	foodProduction = room.dailyFood
	coldProtectionLevel = room.coldProtectionLevel
	
	buildingPanel.hide()
	outsidePanel.hide()
	upgradeButton.show()
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
		self.coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK


func _on_Room_2_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true
		self.coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK


func _on_Room_4_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true
		self.coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK


func _on_Room_5_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true
		self.coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK


func _on_Room_7_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true
		self.coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK


func _on_Room_8_enable_next_room(roomName):
	if (self.name == roomName):
		self.visible = true
		self.coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK


func _on_Close_pressed():
	buildingPanel.hide()
	outsidePanel.hide()
	GameManager.ChangeGameState(GameManager.GameState.RUNNING)


func _on_UpgradeButton_pressed():
	match coldProtectionLevel:
		GameManager.TemperatureState.WARM:
			upgradeButton.texture_normal = upgrade2
			coldProtectionLevel = GameManager.TemperatureState.CHILLY
			coldness = 0
			GameManager.remove_leaves(1)
			roomShader.set("shader_param/Coldness", 0)
			match roomType:
				"Empty":
					pass
				"MushroomRoom":
					foodProduction = 1
				"SleepingRoom":
					foodProduction = 0
		GameManager.TemperatureState.CHILLY:
			upgradeButton.texture_normal = upgrade3
			coldProtectionLevel = GameManager.TemperatureState.COLD
			coldness = 0
			GameManager.remove_leaves(1)
			roomShader.set("shader_param/Coldness", 0)
			match roomType:
				"Empty":
					pass
				"MushroomRoom":
					foodProduction = 1
				"SleepingRoom":
					foodProduction = 0
		GameManager.TemperatureState.COLD:
			upgradeButton.texture_normal = upgrade4
			coldProtectionLevel = GameManager.TemperatureState.FROSTPUNK
			coldness = 0
			GameManager.remove_leaves(1)
			roomShader.set("shader_param/Coldness", 0)
			match roomType:
				"Empty":
					pass
				"MushroomRoom":
					foodProduction = 1
				"SleepingRoom":
					foodProduction = 0
		GameManager.TemperatureState.FROSTPUNK:
			pass
