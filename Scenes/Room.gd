extends Area2D

var buildingPanel: Panel
var outsidePanel: Panel

func _ready():
	buildingPanel = $CanvasLayer/OutsidePanel/BuildingPanel
	outsidePanel = $CanvasLayer/OutsidePanel

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		self.on_click()

func on_click():
	print("Click")
	buildingPanel.show()
	outsidePanel.show()



func _on_OutsidePanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("Outside")
			buildingPanel.hide()
			outsidePanel.hide()


func _on_BuildingPanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("Building")
