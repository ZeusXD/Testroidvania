extends KinematicBody2D


const ACCELERATION = 960
const MAX_SPEED = 150
const FRICTION = 900

var velocity = Vector2.ZERO
onready var animPlayer = $AnimatedSprite

func _physics_process(delta):
	var input_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var input_y = Input.get_action_strength("ui_up")
	
	if input_x < 0:
		animPlayer.flip_h = true
	elif input_x > 0:
		animPlayer.flip_h = false
	
	idle(input_x, input_y)
	running(input_x, delta)
	
	velocity = move_and_slide(velocity,  Vector2.UP)
	
func idle(input_x, input_y):
	if input_x == 0:
		animPlayer.play("idle")
		
	
func running(input_x, delta):
	if input_x != 0:
		velocity = velocity.move_toward(Vector2(input_x, 0) * MAX_SPEED, ACCELERATION * delta)
		animPlayer.play("running")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
