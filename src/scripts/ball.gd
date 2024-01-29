extends CharacterBody2D

const SPEED = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(randf_range(-1, 1), randf_range(0, 1))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	var collision = move_and_collide(velocity * SPEED * delta)
	var collider
	if collision:
		$AudioStreamPlayer2D.play()
		collider = collision.get_collider()
		velocity = velocity.bounce(collision.get_normal())
		if collider == $"../../Bricks/Brick":
			collider.queue_free()
