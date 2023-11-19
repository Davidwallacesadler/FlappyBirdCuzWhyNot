class_name Player extends CharacterBody2D

const DEFAULT_JUMP_VELOCITY = -400.0
const ROTATION_VELOCITY = 50

var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _jump_velocity = DEFAULT_JUMP_VELOCITY

func _ready():
	GameEvents.player_touched_obsticle.connect(_on_touched_obsticle)
	GameEvents.player_touched_floor.connect(_on_touched_obsticle)
	

func _process(delta):
	if self.rotation_degrees < 90:
		self.rotation_degrees += ROTATION_VELOCITY * delta
		
	

func _physics_process(delta):
	self.velocity.y += _gravity * delta
		
	if Input.is_action_just_pressed("ui_accept"):
		self.velocity.y = _jump_velocity
		self.rotation_degrees = lerp(90, 0, 0.75)
		
	
	self.move_and_slide()
	

func reset() -> void:
	_jump_velocity = DEFAULT_JUMP_VELOCITY

func _on_touched_obsticle() -> void:
	_jump_velocity = 0
