extends Node2D

var brickScene = preload("res://src/scenes/brick.tscn")
var ballScene = preload("res://src/scenes/ball.tscn")

var brickInstance
var ballInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	$LivesCounter.set_text("Lives: " + str(Globals.lives))
	
	brickInstance = brickScene.instantiate()
	$Bricks.add_child(brickInstance)
	
	ballInstance = ballScene.instantiate()
	$Balls.add_child(ballInstance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_bottom_body_entered(body):
	Globals.lives -= 1
	$LivesCounter.set_text("Lives: " + str(Globals.lives))
