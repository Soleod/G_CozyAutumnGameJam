extends Node2D

var hedgehogSprite: Sprite
var animationSprite: Sprite
var animationPlayer: AnimationPlayer
var path: PoolVector2Array

var speed: int = 50

func _ready():
	hedgehogSprite = $HedgehogStatic
	animationPlayer = $HedgehogSpriteAnimated/AnimationPlayer
	animationSprite = $HedgehogSpriteAnimated
	path = PoolVector2Array()

func _process(delta):
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * delta
	
	if path.size() == 0:
		hedgehogSprite.visible = true
		animationSprite.visible = false
		animationPlayer.stop()
	else:
		hedgehogSprite.visible = false
		animationSprite.visible = true
		animationPlayer.play("Walking")
	
	# Move the player along the path until he has run out of movement or the path ends.
	if distance_to_walk > 0 and path.size() > 0 and GameManager.currentGameState == GameManager.GameState.RUNNING:
		var distance_to_next_point = position.distance_to(path[0])
		var hedgehogDirectionValue = position.x - path[0].x
		if hedgehogDirectionValue < 0:
			hedgehogSprite.flip_h = true
			animationSprite.flip_h = true
		else:
			hedgehogSprite.flip_h = false
			animationSprite.flip_h = false
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
		
