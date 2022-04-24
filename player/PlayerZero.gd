extends KinematicBody2D


onready var _animated_sprite = $AnimatedSprite

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_pressed("ui_right"):
		_animated_sprite.play("run")
	else:
		#_animated_sprite.stop()
		_animated_sprite.play("idle")
