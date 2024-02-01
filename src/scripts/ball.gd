extends CharacterBody2D

const START_SPEED = 600
const ACCEL : int = 50

var speed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = START_SPEED
	velocity = Vector2(randf_range(-1, 1), randf_range(0, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	var collider
	if collision:
		$AudioStreamPlayer2D.play()
		collider = collision.get_collider()
		if collider == $"../../Player":
			speed += ACCEL
			velocity = velocity.bounce(collision.get_normal())
		else:
			velocity = velocity.bounce(collision.get_normal())
		#print(collider.name)
		if collider.name.match("Brick*"):
			collider.queue_free()
