extends Navigation2D

var roomDict: Dictionary

var combinedFoodProduction = 0
var combinedLodging = 0
var hedgehogs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("clock_tick", self, "_on_clock_tick")
	hedgehogs = [$Hedgehog]
	for room in self.get_children():
		roomDict[room.name] = room
		print(roomDict[room.name].visible)

func _on_clock_tick():
	var tmpFoodProdution = 0
	for room in self.get_children():
		if room is Area2D:
			if room.isActive:
				tmpFoodProdution += room.foodProduction
	combinedFoodProduction = tmpFoodProdution
	print("Food Production: ", combinedFoodProduction)
	GameManager.add_food(combinedFoodProduction - GameManager.hedgehogs)
	for hedgehog in hedgehogs:
		if randi() % 3 == 0:
			var path = self.get_simple_path(hedgehog.position, Vector2(rand_range(0,640), rand_range(0,360)))
			var direction: Vector2 = Vector2.ZERO
			direction = hedgehog.position - path[0]
			hedgehog.path = path


func _on_spawn_hedgehog():
	pass # Replace with function body.


