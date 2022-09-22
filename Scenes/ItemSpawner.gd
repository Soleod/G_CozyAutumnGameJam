extends Area2D

var spawnChancePercentage = 10
var itemResources: Array
var startArea: Vector2
var endArea: Vector2

class ItemResource:
	var resource
	var type: String

	func _init(resource, type):
		self.resource = resource
		self.type = type

# Called when the node enters the scene tree for the first time.
func _ready():
	endArea = $CollisionShape2D.shape.extents
	startArea = $CollisionShape2D.global_position - endArea
	GameManager.connect("clock_tick", self, "_on_tick")
	itemResources = [
		ItemResource.new(load("res://Scenes/FallenLeaf/FallenLeaf.tscn"), "leaves")
	]

func _on_tick():
	if randi() % 100 < spawnChancePercentage:
		_spawn_item()	

func _spawn_item():
	var itemToSpawn = itemResources[randi() % itemResources.size()]
	var spawnedItem = itemToSpawn.resource.instance()
	var spawnPosition = Vector2(rand_range(startArea.x, endArea. x), rand_range(startArea.y, endArea.y))
	spawnedItem.position = spawnPosition
	add_child(spawnedItem)
	print("spawned " + itemToSpawn.type + " at " + spawnPosition.x as String + " " + spawnPosition.y as String)


