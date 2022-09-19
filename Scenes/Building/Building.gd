extends Panel

var buildingName: String
var buildingTexture: StreamTexture
signal build_room(buildingName, buildingTexture)

func _ready():
	buildingName = $Label.text
	buildingTexture = $TextureRect.texture

func _on_Button_pressed():
	emit_signal("build_room", buildingName, buildingTexture)
