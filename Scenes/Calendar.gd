extends TextureRect


func _process(delta):
	$Label.text = String(96 - GameManager.day)
