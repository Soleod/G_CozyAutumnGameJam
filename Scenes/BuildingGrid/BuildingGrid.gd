extends Navigation2D

var roomDict: Dictionary

var combinedFoodProduction = 0
var combinedLodging = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("clock_tick", self, "_on_GameManager_game_tick")
	for room in self.get_children():
		roomDict[room.name] = room
		print(roomDict[room.name].visible)

func _on_GameManager_game_tick():
	print("grid tick")
	var tmpFoodProdution = 0
	for room in self.get_children():
		if room is Area2D:
			tmpFoodProdution += room.foodProduction
	combinedFoodProduction = tmpFoodProdution
	GameManager.food += combinedFoodProduction - GameManager.hedgehogs
	print(GameManager.hedgehogs)
	print(combinedFoodProduction)
	print(GameManager.food)
	var path = self.get_simple_path($Hedgehog.position, Vector2(rand_range(0,640), rand_range(0,360)))
	var direction: Vector2 = Vector2.ZERO
	direction = $Hedgehog.position - path[0]
	print("Direction: ", direction)
	$Line2D.points = path
	$Hedgehog.path = path
