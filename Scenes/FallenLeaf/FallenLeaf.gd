extends RigidBody2D

var clicked = false
var type: String

func _ready():
	$AnimationPlayer.current_animation = "bounce"


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		self._on_click()

func _on_click():
	print("clicked")
	if clicked:
		return
	clicked = true
	match(type):
		"leaves":
			GameManager.add_leaves(1)
		"food":
			GameManager.add_food(1)
		"sticks":
			GameManager.add_sticks(1)
	$AnimationPlayer.current_animation = "fade"
	yield(get_tree().create_timer(1.0), "timeout")
	free()
