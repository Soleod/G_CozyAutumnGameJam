extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var backgroundShader: Material
var hourForShader: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	backgroundShader = self.material
	
func _process(delta):
	if(GameManager.currentGameState == GameManager.GameState.RUNNING):
		hourForShader += delta * (1.0 / GameManager.tick_rate)
		if hourForShader >= 8.0:
			hourForShader -= 8.0
		backgroundShader.set("shader_param/Hour", hourForShader)
		#print(backgroundShader.get("shader_param/Hour"))

func _on_GameManager_game_tick():
	#hourBonus = 0.0
	pass
