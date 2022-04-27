extends KinematicBody2D


const ACCELERATION = 960
const MAX_SPEED = 150
const FRICTION = 900

#Jumping 
export var fallMultiplier = 2 
export var lowJumpMultiplier = 20 
export var jumpVelocity = 450 #Jump height
export (int) var gravity = 8

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
	jump_fall(input_y)
	
	velocity = move_and_slide(velocity,  Vector2.UP)
	
func idle(input_x, input_y):
	if input_x == 0 and input_y == 0 and is_on_floor():
		animPlayer.play("idle")
	
func running(input_x, delta):
	if input_x != 0:
		velocity = velocity.move_toward(Vector2(input_x, 0) * MAX_SPEED, ACCELERATION * delta)
		if is_on_floor():
			animPlayer.play("running")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func jump_fall(input_y):
	#Applying gravity to player
	velocity.y += gravity 

	#Jump Physics
	if velocity.y > 0: #Player is falling
		velocity += Vector2.UP * (-9.81) * (fallMultiplier) #Falling action is faster than jumping action | Like in mario
		if not is_on_floor():
			animPlayer.play("fall")
		
	elif velocity.y < 0 && Input.is_action_just_released("ui_up"): #Player is jumping 
		velocity += Vector2.UP * (-9.81) * (lowJumpMultiplier) #Jump Height depends on how long you will hold key
		
	if is_on_floor():
		if input_y != 0: 
			velocity.y = -jumpVelocity #Normal Jump action
			animPlayer.play("jump")
