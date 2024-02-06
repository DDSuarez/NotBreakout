extends CharacterBody2D

const START_SPEED = 600
const ACCEL : int = 50

var speed : int

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = START_SPEED
	velocity = Vector2(randf_range(-1, 1), 1) # start from the middle of the screen going down at a random angle


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _physics_process(delta):
	var collision = move_and_collide(velocity * speed * delta)
	var collider
	if collision:
		$AudioStreamPlayer2D.play()
		collider = collision.get_collider()
		
		# speed up the ball and do a special bounce if ball hits the player
		# else just do a normal bounce off a wall
		if collider == $"../../Player":
			# check if the ball collides on the sides of the paddle and stop the ball from going all crazy
			# 80 is the distance from the middle of the paddle (-64, 64) plus to the middle of the ball (-16, 16)
			if ((position - collider.position).x > 79 or (position - collider.position).x < -79):
				velocity = velocity.bounce(collision.get_normal())
			else:
				speed += ACCEL
				bounceBall(collider)
		else:
			velocity = velocity.bounce(collision.get_normal())
			
		# if we hit a brick instantiated in buildMap() in the game script
		# so we assume the Bricks are all named "Brick#"
		# we check if the collider matches any "Brick#" and remove it from play if it does	
		if collider.name.match("Brick*"):
			collider.queue_free()

# borrowed from https://github.com/didier-v/breakable
# TODO: understand this code
func bounceBall(collider):
	var ball = position
	var pad = collider.position
	var dist = ball - pad
	
	var coeff = dist.x/collider.paddle_size.x # -0,5 .. 0,5 , depending on where the ball hits the paddle
	var angle = coeff * PI/2.4
	
	velocity.y = -velocity.y
	velocity = velocity.rotated(angle) # relative rotation, keeps speed
	
	adjust_angle() #let the ball adjust the angle so the game keeps being playable
	
func adjust_angle():
	#here we cheat with the angle to make the game more enjoyable
	var min_angle = 20 #below 20, it's too horizontal
	var lv= velocity  #current velocity
	var angle = rad_to_deg(lv.angle_to(Vector2(1,0))) #current angle

	#bounce
	if (angle>0 and angle<min_angle):
		angle=angle-min_angle #<0
	elif (angle<0 and angle>-min_angle):
		angle=angle+min_angle #>0
	elif (angle>180-min_angle and angle<180):
		angle=angle-180+min_angle #>0
	elif (angle<-180+min_angle and angle>-180):
		angle=angle+180-min_angle #<0
	else:
		angle=0
	if angle!=0:
		lv= lv.rotated(deg_to_rad(angle)) # we change the angle, but keep the speed
		velocity = lv 
