extends Node

const START_LIVES = 3

var lives : int
var playerWon : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	lives = START_LIVES
	playerWon = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
