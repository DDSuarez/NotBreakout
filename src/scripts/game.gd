extends Node2D

var brickScene = preload("res://src/scenes/brick.tscn")
var ballScene = preload("res://src/scenes/ball.tscn")

var brickInstance
var ballInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	$LivesCounter.set_text("Lives: " + str(Globals.lives))
	
	build_map()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.lives <= 0:
		get_tree().change_scene_to_file("res://src/scenes/end_screen.tscn")
		
	if $Balls.get_child_count() == 0:
		spawn_ball()
		
		
func spawn_ball():
	ballInstance = ballScene.instantiate()
	$Balls.add_child(ballInstance)


func spawn_brick():
	brickInstance = brickScene.instantiate()
	$Bricks.add_child(brickInstance)
	

func build_map():
	spawn_brick()

func _on_bottom_body_entered(body):
	Globals.lives -= 1
	$LivesCounter.set_text("Lives: " + str(Globals.lives))
	
	body.queue_free()
	
