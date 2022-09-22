extends Navigation2D

var roomDict: Dictionary

var combinedFoodProduction = 0
var combinedLodging = 0
var hedgehogs = []
var expeditionTargetPos: Vector2
var nightMaterial = null

var shadedElements = []

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.connect("clock_tick", self, "_on_clock_tick")
	GameManager.connect("game_tick", self, "_on_game_tick")
	hedgehogs = [$Hedgehog]
	for room in self.get_children():
		roomDict[room.name] = room
		print(roomDict[room.name].visible)
	expeditionTargetPos = $ExpeditionTarget.position
	shadedElements = [$Bush, $Tree, $Grass]
	nightMaterial = load("res://night_dark.tres")

func _on_game_tick():
	var tmpFoodProdution = 0
	for room in self.get_children():
		if room is Area2D:
			tmpFoodProdution += room.foodProduction
	combinedFoodProduction = tmpFoodProdution
	print("Food Production: ", combinedFoodProduction)
	GameManager.add_food(combinedFoodProduction - GameManager.hedgehogs)
	
func _on_clock_tick():
	for hedgehog in hedgehogs:
		var path = null
		if hedgehog.onExpedition:
			path = _get_expedition_path(hedgehog)
		elif randi() % 6 == 0:
			path = _get_normal_path(hedgehog)
		if path != null:
			var direction: Vector2 = Vector2.ZERO
			direction = hedgehog.position - path[0]
			hedgehog.path = path

func _get_expedition_path(hedgehog):
	return self.get_simple_path(hedgehog.position, expeditionTargetPos)

func _get_normal_path(hedgehog):
	return self.get_simple_path(hedgehog.position, Vector2(rand_range(0,620), rand_range(0,360)))

var hourForShader = 1.0

func _process(delta):
	if(GameManager.currentGameState == GameManager.GameState.RUNNING):
		hourForShader += delta * (1.0 / GameManager.tick_rate)
		if hourForShader >= 8.0:
			hourForShader -= 8.0
		for e in shadedElements:
			e.material.set("shader_param/Hour", hourForShader)
		nightMaterial.set("shader_param/Hour", hourForShader)
		for hedgehog in hedgehogs:
			if(hedgehog.material != null):
				hedgehog.material.set("shader_param/Hour", hourForShader)
			if hedgehog.position.y <= 100:
				if(hedgehog.material == null):
					print("setting")
					hedgehog.material = nightMaterial
			elif(hedgehog.material != null):
				print("unsetting")
				hedgehog.material = null

func _on_spawn_hedgehog():
	var hedgehogScene = load("res://Scenes/Hedgehog/Hedgehog.tscn")
	var instance = hedgehogScene.instance()
	add_child_below_node(hedgehogs[0], instance)
	instance.position = Vector2(640, 89)
	hedgehogs.append(instance)
	GameManager.hedgehogs += 1
