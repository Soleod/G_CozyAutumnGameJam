extends Node

var roomDict: Dictionary

var combinedFoodProduction = 0
var combinedLodging = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("game_tick", self, "_on_GameManager_game_tick")
	for room in self.get_children():
		roomDict[room.name] = room
		print(roomDict[room.name].visible)

func _on_GameManager_game_tick():
	print("grid tick")
	var tmpFoodProdution = 0
	for room in self.get_children():
		tmpFoodProdution += room.foodProduction
	combinedFoodProduction = tmpFoodProdution
	GameManager.food += combinedFoodProduction - GameManager.hedgehogs
	print(GameManager.hedgehogs)
	print(combinedFoodProduction)
	print(GameManager.food)


func EnableRoom(roomName: String):
	roomDict[roomName].show()

func _on_RoomL12_enable_next_room():
	EnableRoom("RoomL11")


func _on_RoomL22_enable_next_room():
	EnableRoom("RoomL21")


func _on_RoomL32_enable_next_room():
	EnableRoom("RoomL31")


func _on_RoomR11_enable_next_room():
	EnableRoom("RoomR12")


func _on_RoomR21_enable_next_room():
	EnableRoom("RoomR22")


func _on_RoomR31_enable_next_room():
	EnableRoom("RoomR32")