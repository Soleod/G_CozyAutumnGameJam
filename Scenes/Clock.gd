extends TextureRect

var clockPointer: TextureRect

func _ready():
	clockPointer = $ClockPointer
	GameManager.connect("game_tick", self, "_on_GameManager_game_tick")

func _on_GameManager_game_tick():
	clockPointer.rect_rotation += 60
