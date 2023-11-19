class_name Player extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const ROTATION_VELOCITY = 40

var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var _is_alive := true

func _ready():
	GameEvents.game_over.connect(_on_game_over)
	

func _process(delta):
	if self.rotation_degrees < 90 and _is_alive:
		self.rotation_degrees += ROTATION_VELOCITY * delta
		
	

func _physics_process(delta):
	self.velocity.y += _gravity * delta
		
	if Input.is_action_just_pressed("click") and _is_alive:
		self.velocity.y = JUMP_VELOCITY
		self.rotation_degrees = lerp(90, 0, 0.75)
		
	
	self.move_and_slide()
	

func reset() -> void:
	_is_alive = true
	self.rotation_degrees = 0
	

func _on_game_over() -> void:
	_is_alive = false
	
