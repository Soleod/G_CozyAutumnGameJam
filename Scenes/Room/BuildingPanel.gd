extends Panel

signal build_room(buildingName)

func _on_Button_food_pressed():
	emit_signal("build_room", "MushroomRoom")

func _on_Button_sleep_pressed():
	emit_signal("build_room", "SleepingRoom")
