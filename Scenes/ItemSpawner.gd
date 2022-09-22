extends Area2D

var spawnChancePercentage = 20
var itemResources: Array
var fallenItem
var startArea: Vector2
var endArea: Vector2

class ItemResource:
	var texture
	var type: String

	func _init(texture, type):
		self.texture = texture
		self.type = type

# Called when the node enters the scene tree for the first time.
func _ready():
	endArea = $CollisionShape2D.shape.extents
	startArea = $CollisionShape2D.global_position - endArea
	GameManager.connect("clock_tick", self, "_on_tick")
	fallenItem = load("res://Scenes/FallenLeaf/FallenLeaf.tscn")
	itemResources = [
		ItemResource.new(load("res://Art/UI/Resources/Leaves.png"), "leaves"),
		ItemResource.new(load("res://Art/UI/Resources/Sticks.png"), "sticks"),
		ItemResource.new(load("res://Art/UI/Resources/Food.png"), "food")
	]

func _on_tick():
	if get_child_count() >=5:
		return
	if randi() % 100 < spawnChancePercentage:
		_spawn_item()	

func _spawn_item():
	var itemToSpawn = itemResources[randi() % itemResources.size()]
	var spawnedItem = fallenItem.instance()
	var spawnPosition = Vector2(rand_range(startArea.x, endArea.x * 2), rand_range(startArea.y, endArea.y))
	spawnedItem.position = spawnPosition
	spawnedItem.type = itemToSpawn.type
	spawnedItem.get_node("Sprite").texture = itemToSpawn.texture
	add_child(spawnedItem)
	print("spawned " + itemToSpawn.type + " at " + spawnPosition.x as String + " " + spawnPosition.y as String)


