extends Node2D

@export var gap_min_size: float = 200
@export var gap_max_size: float = 350

@export var max_height: float = 648
@export var width: float = 100
@export var speed: float = 100

@export_category("Internal Nodes")

@export var top_area: Area2D
@export var bottom_area: Area2D
@export var score_area: Area2D

@export var top_collision_shape: CollisionShape2D
@export var bottom_collision_shape: CollisionShape2D
@export var score_collision_shape: CollisionShape2D

@export var top_sprite: Sprite2D
@export var bottom_sprite: Sprite2D

func _ready():
	top_area.body_entered.connect(_on_body_entered_obsticle)
	top_area.area_entered.connect(_on_area_entered_obsticle)
	bottom_area.body_entered.connect(_on_body_entered_obsticle)
	score_area.body_entered.connect(_on_body_entered_score)
	
	top_collision_shape.shape = _create_new_shape()
	bottom_collision_shape.shape = _create_new_shape()
	score_collision_shape.shape = _create_new_shape()
	
	_setup_new_obsticle_gap()

func _process(delta):
	self.position.x -= speed * delta
	

func _setup_new_obsticle_gap() -> void:
	var gap_size = _get_random_gap_size()
	var gap_start_position = _get_gap_start_position(gap_size)
	
	_setup_top_obsticle(gap_start_position)
	
	var gap_end_position = gap_start_position + gap_size
	var bottom_obsticle_height = max_height - gap_end_position
	
	_setup_bottom_obsticle(bottom_obsticle_height)
	_setup_score_area(gap_size, gap_start_position)
	

func _get_random_gap_size() -> float:
	var rng = RandomNumberGenerator.new()
	return rng.randf_range(gap_min_size, gap_max_size)
	

func _get_gap_start_position(gap_size: float) -> float:
	var start = 0.0
	var end = max_height - gap_size
	var rng = RandomNumberGenerator.new()
	return rng.randf_range(start, end)
	

func _setup_top_obsticle(height: float) -> void:
	top_collision_shape.shape.size.y = height
	
	var y_offset_position = height * 0.5
	top_area.position = Vector2(0, y_offset_position)
	
	var image_rect = top_sprite.get_rect()
	var x_scale_factor = width / image_rect.size.x 
	var y_scale_factor = height / image_rect.size.y
	
	top_sprite.scale.x = x_scale_factor
	top_sprite.scale.y = y_scale_factor
	
	var sprite_offset = image_rect.size.y * y_scale_factor * 0.5
	top_sprite.position = Vector2(0, sprite_offset)

func _setup_bottom_obsticle(height: float) -> void:
	bottom_collision_shape.shape.size.y = height
	var y_offset_position = max_height - (height * 0.5)
	bottom_area.position = Vector2(0, y_offset_position)
	
	var image_rect = bottom_sprite.get_rect()
	var x_scale_factor = width / image_rect.size.x 
	var y_scale_factor = height / image_rect.size.y
	
	bottom_sprite.scale.x = x_scale_factor
	bottom_sprite.scale.y = y_scale_factor
	
	var sprite_offset = image_rect.size.y * y_scale_factor * 0.5
	bottom_sprite.position = Vector2(0, max_height - sprite_offset)
	

func _setup_score_area(height: float, y_offset: float) -> void:
	score_collision_shape.shape.size.y = height
	score_collision_shape.shape.size.x = 20
	score_area.position = Vector2(0, y_offset + (height * 0.5))
	

func _create_new_shape() -> RectangleShape2D:
	var new_shape = RectangleShape2D.new()
	new_shape.size.x = width
	return new_shape

func _on_body_entered_obsticle(body: Node2D):
	print("Game Over")
	GameEvents.player_touched_obsticle.emit()

func _on_area_entered_obsticle(area: Area2D):
	self.position = Vector2.ZERO
	_setup_new_obsticle_gap.call_deferred()

func _on_body_entered_score(body: Node2D):
	print("SCORE!")
	GameEvents.player_passed_obsticle.emit()
