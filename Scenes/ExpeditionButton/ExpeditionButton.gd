extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var outsidePanel: Panel
var insidePanel: Panel
signal expedition_started

# Called when the node enters the scene tree for the first time.
func _ready():
	outsidePanel = $CanvasLayer/OutsidePanel
	insidePanel = $CanvasLayer/OutsidePanel/InsidePanel


func _pressed():
	emit_signal("expedition_started")
	match GameManager.currentGameState:
		GameManager.GameState.RUNNING:
			GameManager.ChangeGameState(GameManager.GameState.EXPEDITION)
			insidePanel.show()
			outsidePanel.show()
		GameManager.GameState.PAUSED:
			GameManager.ChangeGameState(GameManager.GameState.EXPEDITION)
			insidePanel.show()
			outsidePanel.show()

func _on_OutsidePanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("Outside Exp")
			insidePanel.hide()
			outsidePanel.hide()
			GameManager.ChangeGameState(GameManager.GameState.RUNNING)
