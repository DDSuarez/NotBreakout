extends Node2D

var brickScene = preload("res://src/scenes/brick.tscn")
var ballScene = preload("res://src/scenes/ball.tscn")

var brick_x = 64
var brick_y = 128

# Called when the node enters the scene tree for the first time.
func _ready():
	build_map()
	$BallTimer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.lives <= 0:
		get_tree().change_scene_to_file("res://src/scenes/end_screen.tscn")
		
	# if all the bricks have been destroyed, game won
	if $Bricks.get_child_count() == 0:
		Globals.playerWon = true
		get_tree().change_scene_to_file("res://src/scenes/end_screen.tscn")

	# spawn a ball if no balls in play
	#if $Balls.get_child_count() == 0:
	#	spawn_ball()
		

# spawn a ball in the middle of the screen
func spawn_ball():
	var ballInstance = ballScene.instantiate()
	ballInstance.position.x = 360
	ballInstance.position.y = 640
	$Balls.add_child(ballInstance, true)


# spawn a brick underneath the Bricks 2D Node with the name given
# once this Bricks node is empty, we know the game is over
func spawn_brick(x, y, name):
	var brickInstance = brickScene.instantiate()
	brickInstance.position = Vector2(x, y)
	brickInstance.set_name(name)
	$Bricks.add_child(brickInstance)
	

# build a basic map of bricks
# each brick added to the Bricks 2D Node with name of Brick#
# then in the ball script, we check if the collider matches "Brick#" and remove it
func build_map():
	var offset_y = 20
	
	for n in 5:
		spawn_brick((n * 128) + 32, offset_y, "Brick" + str(n))
	
	for n in 4:
		spawn_brick((n * 128) + 100, offset_y + (brick_y / 2), "Brick" + str(n + 5))
		
	for n in 5:
		spawn_brick((n * 128) + 32, offset_y + ((brick_y / 2) * 2), "Brick" + str(n + 9))


# remove a life sprite if a life is lost
func _on_bottom_body_entered(body):
	Globals.lives -= 1
	
	if Globals.lives == 2:
		$Lives/Lifesprite3.hide()
	elif Globals.lives == 1:
		$Lives/Lifesprite3.hide()
		$Lives/Lifesprite2.hide()
	
	body.queue_free()
	
	$BallTimer.start()
	


func _on_ball_timer_timeout():
	spawn_ball()
