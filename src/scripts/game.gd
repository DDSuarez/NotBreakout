extends Node2D

var brickScene = preload("res://src/scenes/brick.tscn")
var ballScene = preload("res://src/scenes/ball.tscn")

var brick_x = 64
var brick_y = 128

# Called when the node enters the scene tree for the first time.
func _ready():
	$LivesCounter.set_text("Lives: " + str(Globals.lives))
	
	build_map()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.lives <= 0:
		get_tree().change_scene_to_file("res://src/scenes/end_screen.tscn")
		
	if $Bricks.get_child_count() == 0:
		Globals.playerWon = true
		get_tree().change_scene_to_file("res://src/scenes/end_screen.tscn")

	if $Balls.get_child_count() == 0:
		spawn_ball()
		
		
func spawn_ball():
	var ballInstance = ballScene.instantiate()
	$Balls.add_child(ballInstance, true)


func spawn_brick(x, y, name):
	var brickInstance = brickScene.instantiate()
	brickInstance.position = Vector2(x, y)
	brickInstance.set_name(name)
	$Bricks.add_child(brickInstance)
	

func build_map():
	var offset_y = 20
	
	for n in 5:
		spawn_brick((n * 128) + 32, offset_y, "Brick" + str(n))
	
	for n in 4:
		spawn_brick((n * 128) + 100, offset_y + (brick_y / 2), "Brick" + str(n + 5))
		
	for n in 5:
		spawn_brick((n * 128) + 32, offset_y + ((brick_y / 2) * 2), "Brick" + str(n + 9))

func _on_bottom_body_entered(body):
	Globals.lives -= 1
	$LivesCounter.set_text("Lives: " + str(Globals.lives))
	
	body.queue_free()
	
