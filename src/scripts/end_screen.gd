extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.playerWon:
		$Results.set_text("You win!")
	else:
		$Results.set_text("Try again?")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_replay_button_pressed():
	Globals.playerWon = false
	Globals.lives = Globals.START_LIVES
	get_tree().change_scene_to_file("res://src/scenes/game.tscn")
