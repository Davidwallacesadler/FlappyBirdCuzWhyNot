extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	self.velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept"):
		self.velocity.y = JUMP_VELOCITY
		
	self.move_and_slide()
