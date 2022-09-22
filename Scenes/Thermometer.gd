extends TextureRect


func _process(delta):
	$Panel.rect_size.y = GameManager.currentTemp
	match GameManager.currentTempState:
		GameManager.TemperatureState.WARM:
			$Warm.visible = true
			$Chilly.visible = false
			$Cold.visible = false
			$FrostPunk.visible = false
		GameManager.TemperatureState.CHILLY:
			$Warm.visible = false
			$Chilly.visible = true
			$Cold.visible = false
			$FrostPunk.visible = false
		GameManager.TemperatureState.COLD:
			$Warm.visible = false
			$Chilly.visible = false
			$Cold.visible = true
			$FrostPunk.visible = false
		GameManager.TemperatureState.FROSTPUNK:
			$Warm.visible = false
			$Chilly.visible = false
			$Cold.visible = false
			$FrostPunk.visible = true
