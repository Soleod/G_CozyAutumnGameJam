extends Navigation2D

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
	var tmpFoodProdution = 0
	for room in self.get_children():
		if room is Area2D:
			if room.isActive:
				tmpFoodProdution += room.foodProduction
	combinedFoodProduction = tmpFoodProdution
	print("Food Production: ", combinedFoodProduction)
	GameManager.add_food(combinedFoodProduction - GameManager.hedgehogs)
	var path = self.get_simple_path($Hedgehog.position, Vector2(rand_range(0,640), rand_range(0,360)))
	var direction: Vector2 = Vector2.ZERO
	direction = $Hedgehog.position - path[0]
	$Line2D.points = path
	$Hedgehog.path = path
