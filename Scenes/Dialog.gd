extends Panel

export var dialogText = "Test"

func _ready():
	$DialogText.text = dialogText

func _on_Close_pressed():
	self.hide()

func _on_Ok_pressed():
	self.hide()
