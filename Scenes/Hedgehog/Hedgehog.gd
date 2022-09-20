extends Node2D

enum HedgehogState{
	MOVING,
	WAITING
}

export var velocity = 50
export var groundLevel = 90
export var groundWidth = 600
export var wallOffset = 50


var state:int
var waitTimeLeft:float
var moveStartPosition:Vector2
var moveTargetPosition:Vector2
var moveTime: float

func _ready():
	_start_wait()


func _process(delta):
	match(state):
		HedgehogState.WAITING:
			_wait(delta)
		HedgehogState.MOVING:
			_move(delta)
	

func _start_wait():
	waitTimeLeft = (randi() % 400 + 100) / 100.0
	state = HedgehogState.WAITING
	
func _start_move():
	state = HedgehogState.MOVING
	moveStartPosition = Vector2(position.x, groundLevel)
	moveTargetPosition = Vector2(randi() % (groundWidth - (2 * wallOffset)) + wallOffset, groundLevel)
	moveTime = 0
	

func _wait(delta):
	waitTimeLeft -= delta
	if waitTimeLeft < 0:
		_start_move()

func _move(delta):
	moveTime += delta
	var direction = (moveTargetPosition - moveStartPosition).normalized()
	position = moveStartPosition + (direction * velocity * moveTime)
	if (moveTargetPosition - position).length() < 2:
		_start_wait()
