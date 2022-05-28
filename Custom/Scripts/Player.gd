extends Node2D
onready var animated_sprite = $AnimatedSprite

var velocity = Vector2.ZERO
var max_run = 100
var run_accel = 800
var gravity = 1000
var max_fall = 160
var jump_force = -160
var jump_hold_time = 0.2
var local_hold_time = 0

func _process(delta):
	var direction = sign(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	var on_ground = global_position.y >= 160
	
	var jumping = Input.is_action_pressed("jump")
	if jumping and on_ground:
		velocity.y = jump_force
		local_hold_time = jump_hold_time
	elif local_hold_time > 0:
		if jumping:
			velocity.y = jump_force
		else:
			local_hold_time = 0
	
	if (direction > 0):
		animated_sprite.flip_h = false
	if (direction < 0):
		animated_sprite.flip_h = true
		
	if (direction != 0):
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")
	
	velocity.x = move_toward(velocity.x, max_run * direction, run_accel * delta)
	global_position.x += (velocity.x * delta)
	
	velocity.y = move_toward(velocity.y, max_fall, gravity * delta)
	global_position.y += (velocity.y * delta)
	
	if global_position.y >= 160:
		global_position.y = 160
