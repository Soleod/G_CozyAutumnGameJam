extends Navigation2D

var roomDict: Dictionary

var combinedFoodProduction = 0
var combinedLodging = 0
var hedgehogs = []
var expeditionTargetPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("game_tick", self, "_on_game_tick")
	hedgehogs = [$Hedgehog]
	for room in self.get_children():
		roomDict[room.name] = room
		print(roomDict[room.name].visible)
	expeditionTargetPos = $ExpeditionTarget.position

func _on_game_tick():
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
			var path
			if hedgehog.onExpedition:
				path = _get_expedition_path(hedgehog)
			else:
				path = _get_normal_path(hedgehog)
			var direction: Vector2 = Vector2.ZERO
			direction = hedgehog.position - path[0]
			hedgehog.path = path

func _get_expedition_path(hedgehog):
	return self.get_simple_path(hedgehog.position, expeditionTargetPos)

func _get_normal_path(hedgehog):
	return self.get_simple_path(hedgehog.position, Vector2(rand_range(0,620), rand_range(0,360)))


func _on_spawn_hedgehog():
	var hedgehogScene = load("res://Scenes/Hedgehog/Hedgehog.tscn")
	var instance = hedgehogScene.instance()
	add_child(instance)
	hedgehogs.append(instance)
	GameManager.hedgehogs += 1
