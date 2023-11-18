extends CharacterBody2D

var _gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var _jump_velocity = -400.0

func _ready():
	GameEvents.player_touched_obsticle.connect(_on_touched_obsticle)

func _physics_process(delta):
	self.velocity.y += _gravity * delta
		
	if Input.is_action_just_pressed("ui_accept"):
		self.velocity.y = _jump_velocity
		
	self.move_and_slide()

func _on_touched_obsticle() -> void:
	_jump_velocity = 0
