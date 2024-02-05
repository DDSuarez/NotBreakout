extends StaticBody2D

@onready var screen_size = get_viewport_rect().size
@onready var paddle_size = $ColorRect.get_size()

const SPEED = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("m_left"):
		position.x -= SPEED
	elif Input.is_action_pressed("m_right"):
		position.x += SPEED

	# make sure paddle doesn't leave the screen
	position.x = clampi(position.x, paddle_size.x / 2, screen_size.x - paddle_size.x / 2)
