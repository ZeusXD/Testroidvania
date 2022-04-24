extends KinematicBody2D


const ACCELERATION = 960
const MAX_SPEED = 150
const FRICTION = 900

const GRAVITY = 24
const JUMPSPEED = 500
const FLOOR = Vector2(0, -1)


var velocity = Vector2.ZERO
onready var animPlayer = $AnimatedSprite
	
func _physics_process(delta):
	var input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_y = Input.get_action_strength("ui_up")
	
	
	if input_x < 0:
		animPlayer.flip_h = true
	elif input_x > 0:
		animPlayer.flip_h = false
	
	if input_x == 0 and input_y == 0 and is_on_floor():
		animPlayer.play("idle")

	if input_x != 0:
		velocity = velocity.move_toward(Vector2(input_x, 0) * MAX_SPEED, ACCELERATION * delta)
		if is_on_floor():
			animPlayer.play("running")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if not is_on_floor():
		animPlayer.play("jump")

	if input_y != 0 and is_on_floor():
		velocity.y = 0
		velocity.y = -JUMPSPEED

	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	
	
	
	
	
