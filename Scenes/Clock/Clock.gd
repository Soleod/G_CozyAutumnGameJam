extends TextureRect

var clockPointer: TextureRect

func _ready():
	clockPointer = $ClockPointer
	GameManager.connect("clock_tick", self, "_on_GameManager_game_tick")

func _on_GameManager_game_tick():
	clockPointer.rect_rotation += 45
